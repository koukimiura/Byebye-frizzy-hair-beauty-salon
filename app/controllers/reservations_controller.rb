class ReservationsController < ApplicationController
    
    def index
        
    end
    
    
    def reserved_index
        
    end
    
    
    def choose_menus
        @reservation = Reservation.new
        @menus = Menu.where(category: 1)
        @menus2 = Menu.where(category: 2)
        @menus3 = Menu.where(category: 3)
        @menus4 = Menu.where(category: 4)
        @menus5 = Menu.where(category: 5)
        @menus6 = Menu.where(category: 6)
        
        @haircut = 'カット'
        @colour = 'カラー'
        @curl = 'パーマ'
        @treatment = 'トリートメント'
        @setting_your_hair = 'ヘアセット'
        @other = 'その他'
        
    end
    
    def choosen_menus
        menus = params[:menus]
        #logger.debug("-------menus=#{menus}")
        
        if menus
            selected_Menus = menus.map{ |menu| Menu.find_by(id: menu)}
        end
            
            #logger.debug("-------@selectedMenus=#{@selected_Menus.inspect}")
        
        if selected_Menus
            redirect_to controller: 'reservations', action: 'choose_staff', selected_Menus: selected_Menus
        end
    end

    
    
    def choose_staff
        @selected_Menus = params[:selected_Menus]
        logger.debug("-------@selected_Menus=#{@selected_Menus}")
        @staffs = Staff.all.order(status: :ASC)
        @name = '名前'
        @age = '年齢'
        @gender = '性別'
        @status = '階級'
        
       
        menus=[]
        
        @selected_Menus.each do |selected_Menu|
            if Menu.find_by(id: selected_Menu)
                menus.push(Menu.find_by(id: selected_Menu))
            end
        end
    
        #logger.debug("-------menus=#{menus}")
    
        @menu_ids=[]
        names=[]
        prices=[]
        required_times=[]
    
    
        menus.each do |menu|
            @menu_ids.push(menu.id)
            names.push(menu.name)
            prices.push(menu.price)
            required_times.push(menu.required_time)
        end
        
        
        #logger.debug("-------@menu_ids=#{@menu_ids}")
        
        #文字列をまとめる
        @menu_names = names.join(',')
        
        #各文字列をintegerにして合計金額と時間を出す。
        prices_integer = prices.map{|x| x.to_i}
        @menu_prices = prices_integer.sum
        required_times_integer = required_times.map{|x| x.to_i}
        @menu_required_times = required_times_integer.sum
        #logger.debug("----- @selected_Menus=#{ @selected_Menus}")
        
    end
    
    
    def choosen_staff
        staffId = params[:staff_id]
        menuIds = params[:menu_ids]
        menuNames = params[:menu_names]
        menuPrices = params[:menu_prices]
        menuRequiredTimes = params[:menu_required_times]
        
        logger.debug("-------staffId=#{staffId}")
        logger.debug("-------menuIds=#{menuIds}")
        logger.debug("-------menuNames=#{menuNames}")
        logger.debug("-------menuPrices=#{menuPrices}")
        logger.debug("-------menuRequiredTimes=#{menuRequiredTimes}")
        
        if staffId && menuIds
             redirect_to controller: 'reservations', action: 'choose_date', selected_Staff: staffId, menu_ids: menuIds, menu_names: menuNames,
                                                                            menu_prices: menuPrices, menu_required_times: menuRequiredTimes
        else
            flash.now[:alert] = 'スタイリストを選択してください。'
            render :choose_staff
        end
        
    end
    
    
    def choose_date
        #paramsで受け取ると文字列になる。
        staffId = params[:selected_Staff]
        @menuIds = params[:menu_ids]
        @menuNames = params[:menu_names]
        @menuPrices = params[:menu_prices]
        @menuRequiredTimes = params[:menu_required_times]
        receivedNext = params[:next_week]
        receivedPrev = params[:previous_week]
        
        #文字列で受け取ったので数値に直す。
        @price = @menuPrices.to_i
        @staff = Staff.find(staffId)
        
        
        if receivedNext
            d = Date.parse(receivedNext)
            logger.debug("------d=#{d}")
            
        elsif receivedPrev && Date.parse(receivedPrev) < Date.today  #elsifの順番
            d = Date.today      #- 2.day
            
        elsif receivedPrev
            d = Date.parse(receivedPrev)
            
        else 
            d = Date.today  
        end
        
         @next = d + 1.week #aタグ用
         @prev = d - 1.week #aタグ用
        #d = Date.today + 1.week
        
        @calenders = reservation_calender(d, staffId)
        
        
        
        
         
        logger.debug("-------staffId=#{staffId}")
        logger.debug("-------menuIds=#{@menuIds}")
        logger.debug("-------menuNames=#{@menuNames}")
        logger.debug("-------menuPrices=#{@menuPrices}")
        logger.debug("-------menuRequiredTimes=#{@menuRequiredTimes}")
        
        
        
       
    end
    
    
    def choosen_date
        
        
    end
    
    
    def custamer_detail
        
    end
    
    
    def confirmation
        
    end
    
    
    def create
    
    end
    
    
    def destroy
        reservation = Reservation.find(params[:id])
        reservation.destroy
        flash[:alert] = '予約を削除しました。'
        redirect_to :back
        
    end
    
    private
    
    def reservation_calender(d, staffId)
        logger.debug("-------d=#{d}")
        next_week = d -1 + 1.week
        q = d.beginning_of_month.next_month  #来月のyearとmonth
        
        range = (d..next_week)
        logger.debug("-----range=#{range}")
        schedules = Schedule.where(staff_id: 1).where(date: range)
        logger.debug("-------schedules=#{schedules.inspect}")
        
        next_monthes=[]
        this_monthes=[]
        
        first=[]
        second=[]
        third=[]
        fouth=[]
        fifth=[]
        sixth=[]
        seventh=[]
        
        
        first_status=[]
        second_status=[]
        third_status=[]
        fouth_status=[]
        fifth_status=[]
        sixth_status=[]
        seventh_status=[]
        
        
        
        schedules.each do |schedule|
            date = Date.parse(schedule.date)
                if q.month == d.month
                    next_monthes.push(date)
                else
                    this_monthes.push(date)
                end
                
                if Date.parse(schedule.date) == d
                    first.push(schedule.frame)
                    first_status.push(schedule.frame_status)
                    
                elsif Date.parse(schedule.date) == d + 1
                    second.push(schedule.frame)
                    second_status.push(schedule.frame_status)
                    
                elsif Date.parse(schedule.date) == d + 2
                    third.push(schedule.frame)
                    third_status.push(schedule.frame_status)
                    
                elsif Date.parse(schedule.date) == d + 3
                    fouth.push(schedule.frame)
                    fouth_status.push(schedule.frame_status)
                    
                elsif Date.parse(schedule.date) == d + 4
                    fifth.push(schedule.frame)
                    fifth_status.push(schedule.frame_status)
                    
                elsif Date.parse(schedule.date) == d + 5
                    sixth.push(schedule.frame)
                    sixth_status.push(schedule.frame_status)
                    
                elsif Date.parse(schedule.date) == d + 6
                    seventh.push(schedule.frame)
                    seventh_status.push(schedule.frame_status)
                    
                end        
        end
        
        firstDate =  {date: d, frame: first, status: first_status}
        secondDate =  {date: d +1 , frame: second, status: second_status}
        thirdDate =  {date: d + 2, frame: third, status: third_status}
        fouseDate =  {date: d + 3, frame: fouth, status: fouth_status}
        fifthDate =  {date: d + 4, frame: fifth, status: fifth_status}
        sixthtDate =  {date: d + 5, frame: sixth, status: sixth_status}
        seventhDate =  {date: d + 6, frame: seventh, status: seventh_status}
        
        schs = [firstDate, secondDate, thirdDate, fouseDate, fifthDate, sixthtDate,  seventhDate]
        
        logger.debug("------schs=#{schs.length}")
        
        t_monthes = this_monthes.uniq
        n_monthes = next_monthes.uniq
        
        logger.debug("------t_monthes=#{t_monthes}")
        logger.debug("------n_monthes=#{n_monthes}")
        calender = ''  #ここに帰る。
        
        
        calender << '<thead>' + "\n"
                    
        calender <<  '<tr>'
                    
        calender << '<th rowspan=2 width=16% class=text-center>日時</th>'
        
            if next_monthes.present?
                
                len = n_monthes.uniq.length  #来月の日数は何個入っているか
                number = 7 - len.to_i  #一週間(7日)に対してどれくらいの割合を持っているか。 numberが今月の日数 lenが来月の日数
                logger.debug("-----#{number}")
                mixed_monthes = t_monthes | n_monthes #配列をまとめる
                
                
                t_monthes.zip(n_monthes) do |t, n|
                    #logger.debug("------n.year=#{n.year}")
                    #logger.debug("------t.year=#{t.year}")
                    this = "#{t.year}年#{t.month}月"
                    coming = "#{n.year}年#{n.month}月"
                    
                        case number 
                        
                            when 1 then
                            
                                calender << '<th colspan=1 class=text-center>'
                                
                                calender << this
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=6 class=text-center>'
                                
                                calender << coming
    
                            when 2 then 
                                
                                calender << '<th colspan=2 class=text-center>'
                                
                                calender << this
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=5 class=text-center>'
                                
                                calender << coming
                                
    
                            when 3 then 
                                
                                calender << '<th colspan=3 class=text-center>'
                                
                                calender << this
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=4 class=text-center>'
                                
                                calender << coming
                                
    
                            when 4 then 
                                
                                calender << '<th colspan=4 class=text-center>'
                                
                                calender << this
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=3 class=text-center>'
                                
                                calender << coming
                                
    
                            when 5 then 
                                
                                calender << '<th colspan=5 class=text-center>'
                            
                                calender << this
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=2 class=text-center>'
                                
                                calender << coming
                                
    
                            when 6 then 
                                
                                calender << '<th colspan=6 class=text-center>'
                                
                                calender << this
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=1 class=text-center>'
                                
                                calender << coming
                                
                            #when 7 then
                                
                                #calender << '<th colspan=7 class=text-center>'
                                
                                #this = t.year年t.month月
                                
                                #calender << this
                            
                        
                        end
                        
                    calender << '</th>'
                            
                    calender << ' </tr>'

                    #dateとday
                    logger.debug("----mixed_monthes=#{mixed_monthes}")
                    date_0 = mixed_monthes[0].day
                    wday0 = %w(日 月 火 水 木 金 土)[mixed_monthes[0].wday]
                    date_1 = mixed_monthes[1].day
                    wday1 = %w(日 月 火 水 木 金 土)[mixed_monthes[1].wday]
                    date_2 = mixed_monthes[2].day
                    wday2 = %w(日 月 火 水 木 金 土)[mixed_monthes[2].wday]
                    date_3 = mixed_monthes[3].day
                    wday3 = %w(日 月 火 水 木 金 土)[mixed_monthes[3].wday]
                    date_4 = mixed_monthes[4].day
                    wday4 = %w(日 月 火 水 木 金 土)[mixed_monthes[4].wday]
                    date_5 = mixed_monthes[5].day
                    wday5 = %w(日 月 火 水 木 金 土)[mixed_monthes[5].wday]
                    
                    calender << '<tr>'
                    calender << '<th width=12%>'
                    calender << date_0.to_s
                    calender << '</br>'
                    calender << (wday0)
                    calender << '</th>'
                    calender << '<th width=12%>'
                    calender << date_1.to_s
                    calender << '</br>'
                    calender << (wday1)
                    calender << '<th width=12%>'
                    calender << date_2.to_s
                    calender << '</br>'
                    calender << (wday2)
                    calender << '</th>'
                    calender << '<th width=12%>'
                    calender << date_3.to_s
                    calender << '</br>'
                    calender << (wday3)
                    calender << '</th>'
                    calender << '<th width=12%>'
                    calender << date_4.to_s
                    calender << '</br>'
                    calender << (wday4)
                    calender << '</th>'
                    calender << '<th width=12%>'
                    calender << date_5.to_s
                    calender << '</br>'
                    calender << (wday5)
                    calender << '</th>'
                    calender << '</tr>'
                    
                    
                    #<th width=12%>date_2</br>(wday2)</th><th width=12%>date_3</br>(wday3)</th><th width=12%>date_4</br>(wday4)</th><th width=12%>date_5</br>(wday5)</th></tr
                    #calender << '<tr><th>date_0.day</br>(wday0)</th><th>date_1.day</br>(wday1)</th><th>date_2.day</br>(wday2)</th><th>date_3.day</br>(wday3)</th><th>date_4.day</br>(wday4)</th><th>date_5.day</br>(wday5)</th></tr>'
                end
            else
                 #一週間が全て今月の場合。
                #t.monthes.each do |t|
                    this = "#{t_monthes[0].year}年#{t_monthes[0].month}月"
                    
                    calender << '<th colspan=7 class=text-center>'
                            
                    calender << this
                    
                    calender << '</th>'
                            
                    calender << '</tr>'
                    
                    date_0 = t_monthes[0].day
                    wday0 = %w(日 月 火 水 木 金 土)[t_monthes[0].wday]
                    date_1 = t_monthes[1].day
                    wday1 = %w(日 月 火 水 木 金 土)[t_monthes[1].wday]
                    date_2 = t_monthes[2].day
                    wday2 = %w(日 月 火 水 木 金 土)[t_monthes[2].wday]
                    date_3 = t_monthes[3].day
                    wday3 = %w(日 月 火 水 木 金 土)[t_monthes[3].wday]
                    date_4 = t_monthes[4].day
                    wday4 = %w(日 月 火 水 木 金 土)[t_monthes[4].wday]
                    date_5 = t_monthes[5].day
                    wday5 = %w(日 月 火 水 木 金 土)[t_monthes[5].wday]
                    date_6 = t_monthes[6].day
                    wday6 = %w(日 月 火 水 木 金 土)[t_monthes[6].wday]
                    
                    calender << '<tr>'
                    calender << '<th width=12%>'
                    calender << date_0.to_s
                    calender << '</br>'
                    calender << (wday0)
                    calender << '</th>'
                    calender << '<th width=12%>'
                    calender << date_1.to_s
                    calender << '</br>'
                    calender << (wday1)
                    calender << '<th width=12%>'
                    calender << date_2.to_s
                    calender << '</br>'
                    calender << (wday2)
                    calender << '</th>'
                    calender << '<th width=12%>'
                    calender << date_3.to_s
                    calender << '</br>'
                    calender << (wday3)
                    calender << '</th>'
                    calender << '<th width=12%>'
                    calender << date_4.to_s
                    calender << '</br>'
                    calender << (wday4)
                    calender << '</th>'
                    calender << '<th width=12%>'
                    calender << date_5.to_s
                    calender << '</br>'
                    calender << (wday5)
                    calender << '</th>'
                    calender << '<th width=12%>'
                    calender << date_6.to_s
                    calender << '</br>'
                    calender << (wday6)
                    calender << '</th>'
                    calender << '</tr>'
            end
        
        calender << '</thead>'

        
        #times = ["10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
                 #"16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30"] 
                 
        calender << '<tbody>'
                    
             
        logger.debug("-------first=#{first.inspect}")
        logger.debug("-------second=#{second.inspect}")
        logger.debug("-------third=#{third.inspect}")
        logger.debug("-------fouth=#{fouth.inspect}")
        logger.debug("-------fifth=#{fifth.inspect}")
        logger.debug("-------sixth=#{sixth.inspect}")
        logger.debug("-------seventh=#{seventh.inspect}")
        
        
        working_hours = ["10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
                        "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30"] 
        
        #times.zip(sches) do |time, sch|
        
        calender_size = working_hours.length* 7
       
       
        
        (calender_size/7).times do |i|
            calender << "\t" + '<tr>'
            hour= working_hours[i]
            logger.debug("-----hour=#{hour}")
            calender << '<td>'
            calender << hour
            calender <<'</td>' 
            
           #7.times do 
            calender << '<td>'
            #schs.each do |sch| 
            #logger.debug("-----schs=#{schs.inspect}")
               #first = schs[0]
               #first[:frame].zip(first[:status]) do |f, s|
               #first[:status].each do |s|
                   #ogger.debug("----time=#{Time.parse(f)}")
               #if first[:frame].include?(working_hours[i]) && t_monthes[0] == first[:date] && s == "available"
               if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[0], frame_status: "available")
                   a = 'maru'
                  calender << a
                   #logger.debug("-----f=#{f}")
                   
               #elsif f == working_hours[i] && t_monthes[0] == first[:date] && s == "reserved"
                   # calender << 'バツ'
                    
                    
                elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[0], frame_status: "reserved")
                   a = 'バツ'
                   calender << a     
                #elsif first[:frame].exclude?(working_hours[i]) && t_monthes[0] == first[:date] 
                else
                       c = "-"
                
                    calender << c
               end
               #end
               calender << '</td>'
               
               calender << '<td>'
                if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[1], frame_status: "available")
                   a = 'maru'
                  calender << a
                   #logger.debug("-----f=#{f}")
                   
               #elsif f == working_hours[i] && t_monthes[0] == first[:date] && s == "reserved"
                   # calender << 'バツ'
                    
                        
                #elsif first[:frame].exclude?(working_hours[i]) && t_monthes[0] == first[:date] 
                else
                       c = "-"
                
                    calender << c
               end
               
               
              calender << '</td>'
              
              calender << '<td>'
                if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[2], frame_status: "available")
                   a = 'maru'
                  calender << a
                   #logger.debug("-----f=#{f}")
                   
               #elsif f == working_hours[i] && t_monthes[0] == first[:date] && s == "reserved"
                   # calender << 'バツ'
                    
                        
                #elsif first[:frame].exclude?(working_hours[i]) && t_monthes[0] == first[:date] 
                else
                       c = "-"
                
                    calender << c
               end
               
               
              calender << '</td>'
              
              calender << '<td>'
                if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[3], frame_status: "available")
                   a = 'maru'
                  calender << a
                   #logger.debug("-----f=#{f}")
                   
               #elsif f == working_hours[i] && t_monthes[0] == first[:date] && s == "reserved"
                   # calender << 'バツ'
                    
                        
                #elsif first[:frame].exclude?(working_hours[i]) && t_monthes[0] == first[:date] 
                else
                       c = "-"
                
                    calender << c
               end
               
               
              calender << '</td>'
              
              calender << '<td>'
                if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[4], frame_status: "available")
                   a = 'maru'
                  calender << a
                   #logger.debug("-----f=#{f}")
                   
               #elsif f == working_hours[i] && t_monthes[0] == first[:date] && s == "reserved"
                   # calender << 'バツ'
                    
                        
                #elsif first[:frame].exclude?(working_hours[i]) && t_monthes[0] == first[:date] 
                else
                       c = "-"
                
                    calender << c
               end
               
               
              calender << '</td>'
              
              calender << '<td>'
                if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[5], frame_status: "available")
                   a = 'maru'
                  calender << a
                   #logger.debug("-----f=#{f}")
                   
               #elsif f == working_hours[i] && t_monthes[0] == first[:date] && s == "reserved"
                   # calender << 'バツ'
                    
                        
                #elsif first[:frame].exclude?(working_hours[i]) && t_monthes[0] == first[:date] 
                else
                       c = "-"
                
                    calender << c
               end
               
               
              calender << '</td>'
              
              calender << '<td>'
                if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[6], frame_status: "available")
                   a = 'maru'
                  calender << a
                   #logger.debug("-----f=#{f}")
                   
               #elsif f == working_hours[i] && t_monthes[0] == first[:date] && s == "reserved"
                   # calender << 'バツ'
                    
                        
                #elsif first[:frame].exclude?(working_hours[i]) && t_monthes[0] == first[:date] 
                else
                       c = "-"
                
                    calender << c
               end
               
               
              calender << '</td>'
            #end
            
            #f != working_hours[i]
            
            
           calender << '</tr>' + "\n"
           
        end
        
       # times.each do |time|
        #    calender << '<tr>'
           # calender << '<td>'
           # calender << time
           # calender << '</td>'
        #end    
            
            #lines=[]
            #i = 0
            #while i < 7 do
                #sch =  schs[i]
                #frame_times = sch[:frame]
                #logger.debug("------frame_times=#{frame_times}")
                #times.each do |time|
                    #frame_times.each do |frame|
                        #if  frame == time #t_monthes[0] == i[:date] &&
                            
                            #lines << '<td>まる</td>'
                        #else
                            
                            #lines <<'<td>バツ</td>'
                        #end    
                   # end 
                #end
                # i += 1
           # end
            
            #logger.debug("------line=#{lines}")
            #lines.each do |line|
               # calender << line
            #end
            
            #calender << '</tr>'
        #end

        
        calender << '</tbody>'
        return calender
    end
end
