module ReservationsHelper

    def reservation_calender(d, staff, menuRequiredTimes)
        logger.debug("-------d=#{d}")
        
        next_week = d -1 + 1.week
        q = d.beginning_of_month.next_month  #来月のyearとmonth
        
        range = (d..next_week) #一週間分のyear month dateを取得し
        #schedules = Schedule.where(staff_id: 1).where(date: range)

        next_dates=[]
        specified_dates=[]  #今月またはnext_datesの前の月, つまり今月からみた再来月はspcifiedになる。
        
        rangeDates=[]
        
        #schedules.each do |schedule|
            #date = Date.parse(schedule.date)
            range.each do |r|
                #if q.month == date.month
                if q.month == r.month
                    #next_dates.push(date)
                    next_dates.push(r)
                else
                    #specified_dates.push(date)
                    specified_dates.push(r)
                end
                
                rangeDates << r    #range[0]のようにrangeをインデックス 指定して取り出しできないので配列の作り直し。
            end
       # end
        
        
        n_dates = next_dates.uniq
        s_dates = specified_dates.uniq
        logger.debug("------s_dates=#{s_dates}")
        logger.debug("------n_dates=#{n_dates}")
        
        specified = "#{s_dates[0].year}年#{s_dates[0].month}月" #指定された月
        
       
        #---------------------------------------

        #ここから作ります。
        
        calender = ''  #ここに帰る。
        
        calender << '<thead>' + "\n"
                    
        calender << '<tr>'
                    
        calender << '<th rowspan=2 width=16% class=text-center>日時</th>'
        
            if next_dates.present?
                
                len = n_dates.uniq.length                  #来月の日数は何個入っているか
                number = 7 - len.to_i                      #一週間(7日)に対してどれくらいの割合を持っているか。 numberが今月の日数  lenが来月の日数
                
                logger.debug("-----number#{number}")
                mixed_dates = s_dates | n_dates   #配列をまとめる
                
                #t_monthes.zip(n_monthes) do |t, n|
                    #logger.debug("------n.year=#{n.year}")
                    #logger.debug("------t.year=#{t.year}")
                    #this = "#{t.year}年#{t.month}月"
                    #coming = "#{n.year}年#{n.month}月"
                #end    
            
               #specified = "#{s_dates[0].year}年#{s_dates[0].month}月"
                coming = "#{n_dates[0].year}年#{n_dates[0].month}月"
                
                logger.debug("--------specified=#{specified}")
                logger.debug("--------coming=#{coming}")
                
                        case number
                        
                            when 1 then
                            
                                calender << '<th colspan=1 class=text-center>'
                                
                                calender << specified
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=6 class=text-center>'
                                
                                calender << coming
    
                            when 2 then 
                                
                                calender << '<th colspan=2 class=text-center>'
                                
                                calender << specified
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=5 class=text-center>'
                                
                                calender << coming
                                
    
                            when 3 then 
                                
                                calender << '<th colspan=3 class=text-center>'
                                
                                calender << specified
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=4 class=text-center>'
                                
                                calender << coming
                                
    
                            when 4 then 
                                
                                calender << '<th colspan=4 class=text-center>'
                                
                                calender << specified
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=3 class=text-center>'
                                
                                calender << coming
                                
    
                            when 5 then 
                                
                                calender << '<th colspan=5 class=text-center>'
                            
                                calender << specified
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=2 class=text-center>'
                                
                                calender << coming
                                
    
                            when 6 then 
                                
                                calender << '<th colspan=6 class=text-center>'
                                
                                calender << specified
                                
                                calender << '</th>'
                                
                                calender << '<th colspan=1 class=text-center>'
                                
                                calender << coming
                            
                        end

                    #calender << '</th>'
                            
                    #calender << ' </tr>'

                    
            else
                 #一週間が全て今月の場合。
                 #t.monthes.each do |t|
                    #this = "#{t_monthes[0].year}年#{t_monthes[0].month}月"
                    
                    calender << '<th colspan=7 class=text-center>'
                            
                    calender << specified
                    
                    #calender << '</th>'
                            
                    #calender << '</tr>'
                    
            end
            
          calender << '</th>'
                            
          calender << ' </tr>'
                    
          logger.debug("---------rangeDates=#{rangeDates[0]}")          
                    #dateとday
                    date_0 = rangeDates[0].day
                    wday0 = %w(日 月 火 水 木 金 土)[rangeDates[0].wday]
                    date_1 = rangeDates[1].day
                    wday1 = %w(日 月 火 水 木 金 土)[rangeDates[1].wday]
                    date_2 = rangeDates[2].day
                    wday2 = %w(日 月 火 水 木 金 土)[rangeDates[2].wday]
                    date_3 = rangeDates[3].day
                    wday3 = %w(日 月 火 水 木 金 土)[rangeDates[3].wday]
                    date_4 = rangeDates[4].day
                    wday4 = %w(日 月 火 水 木 金 土)[rangeDates[4].wday]
                    date_5 = rangeDates[5].day
                    wday5 = %w(日 月 火 水 木 金 土)[rangeDates[5].wday]
                    date_6 = rangeDates[6].day
                    wday6 = %w(日 月 火 水 木 金 土)[rangeDates[6].wday]
                    
                    
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
            #end
        
        calender << '</thead>'

        
                    
        #予約カレンダーアルゴリズム----------------------------------------------------------------
        
        calender << '<tbody>'
        
        #カレンダーのマス個数決め   あくまで予約時間　9:30と21:00は準備　preparation period
        working_hours = ["10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
                        "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30"]
                        
        
        
        calender_size = working_hours.length* 7
       
        #マスの数を一週間でわる　i= 0から21まで
        (calender_size/7).times do |i|
            calender << "\t" + '<tr>'
            hour = working_hours[i]
            calender << '<td>'
            calender << hour
            calender <<'</td>' 
            
           #7.times do 
            #schs.each do |sch| 
            #logger.debug("-----schs=#{schs.inspect}")
               #first = schs[0]
               #first[:frame].zip(first[:status]) do |f, s|
               #first[:status].each do |s|
                   #ogger.debug("----time=#{Time.parse(f)}")
               #if first[:frame].include?(working_hours[i]) && t_monthes[0] == first[:date] && s == "available"
                   #logger.debug("-----f=#{f}")
               #elsif f == working_hours[i] && t_monthes[0] == first[:date] && s == "reserved"
                   # calender << 'バツ'
                #elsif first[:frame].exclude?(working_hours[i]) && t_monthes[0] == first[:date] 
                #7.times do 
                
                                            #9:30と21:00は準備　preparation periodを撮ってこないため   availableしてなので#9:30と21:00はとってこない
            staffSchedules = Schedule.where(staff_id: 1, date: range[0], frame_status: "available")
            scheduleFrmaes = staffSchedules.map{|schedule| schedule.frame}
            
            #if  scheduleFrmaes.include?("9:30","21:00")
                #newFrames = scheduleFrmaes.map{|schedule| }
            #end
            
            #frame_number = scheduleFrmaes.length
            #requiredTime = frame_number * 30 
            
            #表示を変えなければならいないマスの数がわかる。 １ひく　4ならケツの３カラムを"-"にする。
            #logger.debug("-------menuRequiredTimes=#{menuRequiredTimes.to_i}")
            
            # 必要時間に応じた30分単位のカラム数を取得。　そこから -1をして表示を変更するカラム数を求める。　　
            #例　menuRequiredTimes(120)から30で割って4カラム必要となる。そこから表示するのは先頭の1カラムで良いので残り3つは"-"
            
            
                            #Float化して少数点まで求める。    menuRequiredTimesは選択されたメニューの時間 
            calumn_number = menuRequiredTimes.to_f / 30 #- 1
            
            #availableCalum = menuRequiredTimes.to_i - calumn_number
            
                if calumn_number < 1
                    number_integer = 0
                    
                elsif calumn_number ==  Float  #Flootの場合。
                    number_integer = calumn_number.to_i

                else  #calumn_numberが30で割り切れた場合
                    number_integer = calumn_number.to_i - 1
                end
            
            #配列から"-"分のカラム数に対応する配列の要素を取得
            unavailableCalumns = scheduleFrmaes.last(number_integer)
            
            
            
            logger.debug("----------menuRequiredTimes.to_i=#{menuRequiredTimes.to_f}")
            logger.debug("----------calumn_number=#{calumn_number}")
            logger.debug("--------number_integer=#{number_integer}")
            logger.debug("--------unavailableCalumns=#{unavailableCalumns}")
            

                
            #初日    
            calender << '<td>'
                 
                #予約済み   
                if  Schedule.find_by(staff_id: 1, frame: working_hours[i], date: s_dates[0], frame_status: "reserved")
                    
                    calender << '✖'
                                                        
                #elsif menuRequiredTimes.to_i >= 90 && unavailableCalumns.include?(working_hours[i])
                    #Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[0], frame_status: "available")
                
                    #calender << "-"
                    
                    
                #elsif  menuRequiredTimes.to_i >= 60 && working_hours[i] == lastThirdperid.last
                    #Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[0], frame_status: "available")
                    
                    #calender << "-"
                    
                    
                #予約不可
                elsif unavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[0], frame_status: "available")

                   calender << '-'    
                    
                    
                    
                  #予約可   
                elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[0], frame_status: "available")                    
                    
                    circle = link_to '◎', custamer_detail_reservations_path(selected_Staff: @staff.id, menu_ids: @menuIds, menu_names: @menuNames,
                                            menu_prices: @price, menu_required_times: @menuRequiredTimes, date: t_monthes[0], frame: working_hours[i]), class:'date-link'
                    
                    calender << circle
                    
                   
                #出勤しない日   
                else
                
                    calender << "-"
                end
                
            calender << '</td>'
            
            #二日目
            calender << '<td>'
            
            
                #予約可
               # if menuRequiredTimes <= 30 &&
                 if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[1], frame_status: "available")
                    
                    
                    circle = link_to '◎', custamer_detail_reservations_path(selected_Staff: @staff.id, menu_ids: @menuIds, menu_names: @menuNames,
                                            menu_prices: @price, menu_required_times: @menuRequiredTimes, date: t_monthes[0], frame: working_hours[i]), class:'date-link'
                    
                    calender << circle
    
                 #予約不可
                elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[1], frame_status: "reserved")
                     
                     calender << '✖️'  
                
                #出勤しない日 
                else

                    calender << "-"
                end
            
            calender << '</td>'
              
            #3日目
            calender << '<td>'
            
                #予約可
                if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[2], frame_status: "available")
                    
                    circle = link_to '◎', custamer_detail_reservations_path(selected_Staff: @staff.id, menu_ids: @menuIds, menu_names: @menuNames,
                                            menu_prices: @price, menu_required_times: @menuRequiredTimes, date: t_monthes[0], frame: working_hours[i]), class:'date-link'
                    
                    calender << circle
    
                 #予約不可
                elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[2], frame_status: "reserved")
                     
                     calender << '✖️'
                
                #出勤しない日 
                else

                    calender << "-"

                end
            
            calender << '</td>'


            #4日目
            calender << '<td>'
            
                #予約可
                if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[3], frame_status: "available")
                    
                    circle = link_to '◎', custamer_detail_reservations_path(selected_Staff: @staff.id, menu_ids: @menuIds, menu_names: @menuNames,
                                            menu_prices: @price, menu_required_times: @menuRequiredTimes, date: t_monthes[0], frame: working_hours[i]), class:'date-link'
                   
                   calender << circle
                   
                 #予約不可
                elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[3], frame_status: "reserved")
                    
                    calender << '✖️'
                
                #出勤しない日 
                else
                   
                
                    calender << "-"
                end
            
            calender << '</td>'

            #5日目
            calender << '<td>'
            
                #予約可
                if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[4], frame_status: "available")
                   
                    circle = link_to '◎', custamer_detail_reservations_path(selected_Staff: @staff.id, menu_ids: @menuIds, menu_names: @menuNames,
                                            menu_prices: @price, menu_required_times: @menuRequiredTimes, date: t_monthes[0], frame: working_hours[i]), class:'date-link'
                    
                    calender << circle
    
                 #予約不可
                elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[4], frame_status: "reserved")
                    
                    calender << '✖️'
                    
                #出勤しない日 
                else
                    calender << "-"
                end
            
            calender << '</td>'

            #6日目
            calender << '<td>'
            
                #予約可
                if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[5], frame_status: "available")

                    circle = link_to '◎', custamer_detail_reservations_path(selected_Staff: @staff.id, menu_ids: @menuIds, menu_names: @menuNames,
                                            menu_prices: @price, menu_required_times: @menuRequiredTimes, date: t_monthes[0], frame: working_hours[i]), class:'date-link'

                    calender << circle
    
                 #予約不可
                elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[5], frame_status: "reserved")
                     
                     calender << '✖️' 
                
                #出勤しない日 
                else
                    
                    calender << "-"
                end
            
            calender << '</td>'


            #7日目
            calender << '<td>'
            
                #予約可
                if Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[6], frame_status: "available")

                    circle = link_to '◎', custamer_detail_reservations_path(selected_Staff: @staff.id, menu_ids: @menuIds, menu_names: @menuNames,
                                            menu_prices: @price, menu_required_times: @menuRequiredTimes, date: t_monthes[0], frame: working_hours[i]), class:'date-link'

                    calender << circle
    
                 #予約不可
                elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: t_monthes[6], frame_status: "reserved")
                     
                     calender << '✖️'
                
                #出勤しない日 
                else
                   
                   calender << "-"
                   
                end
            
            calender << '</td>'
            
            
           calender << '</tr>' + "\n"
           
        end  #calender_size
                        
                        
        
        calender << '</tbody>'                
                        
             
        return calender           
    end
end