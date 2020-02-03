module ReservationsHelper
    
    #def reservation_menu_number_to_currency(menu)
        #"￥#{menu.price.to_s(:delimited)}"
    #end


    def reservation_calender(d, staff, menuRequiredTimes)

        next_week = d - 1 + 1.week
        q = d.beginning_of_month.next_month  #来月のyearとmonth
        
        range = (d..next_week) #一週間分のyear month dateを取得し

        next_dates=[]
        specified_dates=[]  #今月またはnext_datesの前の月, つまり今月からみた再来月はspcifiedになる。
        
        rangeDates=[]       #range[0]のようにrangeをインデックス 指定して取り出しできないので配列の作り直し。            
        
            range.each do |r|
                if q.month == r.month
                    next_dates.push(r)
                else
                    specified_dates.push(r)
                end
                
                rangeDates << r    #range[0]のようにrangeをインデックス 指定して取り出しできないので配列の作り直し。 .ex 2019-12-12
            end
        
        n_dates = next_dates.uniq
        s_dates = specified_dates.uniq

        specified = "#{s_dates[0].year}年#{s_dates[0].month}月" #指定された月
    
        #Float化して少数点まで求める。    menuRequiredTimesは選択されたメニューの時間
        calumn_number = menuRequiredTimes.to_f / 30 #- 1
        
        #schedule.rbに書いてあるよ
        staffSchedules = Schedule.searchStaff(staff).searchRangeDate(range).notPreparation_period
        
#-------------ここから作ります。--------------------------
        calender = ''  #ここに帰る。
        
        calender << '<thead>' + "\n"
                    
        calender << '<tr>'
                    
        calender << '<th rowspan=2 width=16% class=text-center>日時</th>'
        
            if next_dates.present?
                #来月の日数は何個入っているか
                #一週間(7日)に対してどれくらいの割合を持っているか。 numberが今月の日数  lenが来月の日数
                
                len = n_dates.uniq.length                  
                number = 7 - len.to_i                      
                
                coming = "#{n_dates[0].year}年#{n_dates[0].month}月"
                
                #logger.debug("--------specified=#{specified}")
                #logger.debug("--------coming=#{coming}")
                
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
            else
                    calender << '<th colspan=7 class=text-center>'
                            
                    calender << specified
            end
            
          calender << '</th>'
                            
          calender << ' </tr>'
                    
                    
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

        calender << '</thead>'
        
#------------予約カレンダーアルゴリズム(処理)----------------------------------------------------------------
        
        calender << '<tbody>'
        
        #カレンダーのマス個数決め   あくまで予約時間　9:30と21:00は準備　preparation period
        working_hours = ["10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
                        "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30"]
             
             
        #その日の出勤時間が出る。  予約可か予約済みかで配列分ている。 
        
        #序数名詞DatesFramesはavailable
        #序数名詞DatesReservedFramesはreservedとkeep
        
        firstDatesFrames=[]
        firstDatesReservedFrames=[]
        
        secondDatesFrames=[]
        secondDatesReservedFrames=[]
        
        thirdDatesFrames=[]
        thirdDatesReservedFrames=[]
        
        fouseDatesFrames=[]
        fouseDatesReservedFrames=[]
        
        fifthDatesFrames=[]
        fifthDatesReservedFrames=[]
        
        sixthDatesFrames=[]
        sixthDatesReservedFrames=[]
        
        seventhDatesFrames=[]
        seventhDatesReservedFrames=[]
        
        #calenderを回す前にある。
        staffSchedules.each do |schedule|
            #parseで文字列を直す
            date = Date.parse(schedule.date)
            case date 
                
                #この時点でframe_status breakとDBに保存されていない時間（出勤前、退勤後）は配列に入らない　省かれる。
                when rangeDates[0] then
                    firstDatesFrames.push(schedule.frame) if schedule.frame_status == 'available'  
                    
                    firstDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'keep'
                    
                when rangeDates[1] then
                    
                    secondDatesFrames.push(schedule.frame) if schedule.frame_status == 'available'
                    
                    secondDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'keep'
                    
                when rangeDates[2] then

                    thirdDatesFrames.push(schedule.frame)  if schedule.frame_status == 'available'
                    
                    thirdDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'keep'

                when rangeDates[3] then
                    
                    fouseDatesFrames.push(schedule.frame) if schedule.frame_status == 'available'  
                    
                    fouseDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'keep'
                    
                when rangeDates[4] then
                    
                    fifthDatesFrames.push(schedule.frame) if schedule.frame_status == 'available' 
                    
                    fifthDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'keep'
                    
                when rangeDates[5] then
                    
                    sixthDatesFrames.push(schedule.frame) if schedule.frame_status == 'available'  
                    
                    sixthDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'keep'
                    
                when rangeDates[6] then  
                    
                    seventhDatesFrames.push(schedule.frame) if schedule.frame_status == 'available' 
                    
                    seventhDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'keep'
                    
            end
        end
   
#frame_statusがrevervedとkeepが入っている配列を

#working_hoursはarray10:00~20:30の営業時間s
#-------初日----------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        firstDatePreviousReservedFrames=[]
        
        firstDatesReservedFrames.each do |f|
            #例 16:30と17:00がreservedまたはkeepであった場合、17:00がreservedのため16:30はfirstDatePreviousReservedFramesに格納される。
            #previousTimesはframe_statusがreservedかkeepの時間帯より前の時間を格納してる。
            
            #logger.debug("-------------f=#{f}")
            previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(f) }
            #logger.debug("----------previousTimes=#{previousTimes}")
        
            #calumnメソッドを呼び出す。これは取得する要素数
            #previousTimesの最後の時間を取得
            firstDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
        end

        #logger.debug("----------firstDatePreviousReservedFrames=#{firstDatePreviousReservedFrames}")
        
        #二次元配列を一次元配列に直す
        firstDatePRF=[]
        
        firstDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                firstDatePRF << x
            end
        end
     
        #logger.debug("--------------firstDatePRF=#{firstDatePRF}")
        
 
#-------2日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        secondDatePreviousReservedFrames=[]
        
        secondDatesReservedFrames.each do |s|
            previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(s) }
            
            #calumnメソッドを呼び出す。これは取得する要素数
            secondDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
        end

        #二次元配列を一次元配列に直す。
        secondDatePRF=[]
        
        secondDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                secondDatePRF << x
            end
        end
     
#-------3日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        thirdDatePreviousReservedFrames=[]
        
        thirdDatesReservedFrames.each do |t|
            previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(t) }

            #calumnメソッドを呼び出す。これは取得する要素数
            thirdDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
        end

        #二次元配列を一次元配列に直す。
        thirdDatePRF=[]
        
        thirdDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                thirdDatePRF << x
            end
        end
     
#-------4日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        fouseDatePreviousReservedFrames=[]
        
        fouseDatesReservedFrames.each do |f|
            previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(f) }

            #calumnメソッドを呼び出す。これは取得する要素数
            fouseDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
        end

        #二次元配列を一次元配列に直す。
        fouseDatePRF=[]
        
        fouseDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                fouseDatePRF << x
            end
        end
     
#-------5日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        fifthDatePreviousReservedFrames=[]
        
        fifthDatesReservedFrames.each do |f|
            previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(f) }

            #calumnメソッドを呼び出す。これは取得する要素数
            fifthDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
        end

        #二次元配列を一次元配列に直す。
        fifthDatePRF=[]
        
        fifthDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                fifthDatePRF << x
            end
        end
#-------6日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        sixthDatePreviousReservedFrames=[]
        
        sixthDatesReservedFrames.each do |f|
            previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(f) }
            
            #calumnメソッドを呼び出す。これは取得する要素数
            sixthDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
        end

        #二次元配列を一次元配列に直す。
        sixthDatePRF=[]
    
        sixthDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                sixthDatePRF << x
            end
        end
#-------7日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        seventhDatePreviousReservedFrames=[]
        
        seventhDatesReservedFrames.each do |s|
            previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(s) }
            
            #calumnメソッドを呼び出す。これは取得する要素数
            seventhDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
        end

        #二次元配列を一次元配列に直す。
        seventhDatePRF=[]
        
        seventhDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                firstDatePRF << x
            end
        end
        
#---------------------------------------------------------------------------------

        #配列から"-"分のカラム数に対応する配列の要素を取得
        #退勤時間からcalumn_number数分表示をかえる。
        
        #A君が18:00退勤の場合彼の最後予約可能時間は17:30である。もしお客さんが60分かかるメニューを選択し、A君の17:30のコマを予約した場合はA君は18：30まで仕事することになるので、
        #意図的に17:30を予約できないように表示を変える.
        #下記は変更するカラム（コマ）数を決めている。
        firstunavailableCalumns = firstDatesFrames.last(calumn(calumn_number))
        secondunavailableCalumns = secondDatesFrames.last(calumn(calumn_number))
        thirdunavailableCalumns = thirdDatesFrames.last(calumn(calumn_number))
        fouseunavailableCalumns = fouseDatesFrames.last(calumn(calumn_number))
        fifthunavailableCalumns = fifthDatesFrames.last(calumn(calumn_number))
        sixthunavailableCalumns = sixthDatesFrames.last(calumn(calumn_number))
        seventhunavailableCalumns = seventhDatesFrames.last(calumn(calumn_number))

#------------viewに出ている処理。まる、バツ、ハイフンはここで作ってます。--------------------
        
        calender_size = working_hours.length* 7
       
        #マスの数を一週間でわる　i= 0から21まで
        (calender_size/7).times do |i|
            calender << "\t" + '<tr>'
            
            hour = working_hours[i]
            
            calender << '<td>'
            
            calender << hour
            
            calender << '</td>' 
        
#------------初日-----------------------------------------------------------------   

            calender << '<td>'
                 
                #Required_timeに応じたreserved(予約済み時間)の前の時間   必ず "reserved"の上
                if firstDatePRF.include?(working_hours[i])
                 
                    calender << '✖'
                
                #予約済み    frame_status: "reserved" または　pre-reserved
                elsif firstDatesReservedFrames.include?(working_hours[i])

                    calender << '✖'

                #予約不可  RequiredTimeに応じた退勤時間からの処理 ex. 必要時間90分に対して退勤時間から２つ上のカラムを削る
                elsif firstunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: staff, frame: working_hours[i], date: rangeDates[0], frame_status: "available")

                   calender << '-'    
                    
                #予約可    firstDatesFrames.include?(working_hours[i])  frame_status: 'avaiable'
                elsif firstDatesFrames.include?(working_hours[i])

                    circle = link_to '◎', custamer_detail_reservations_path(selectedStaff: @staff.id, menu_required_times: @menuRequiredTimes,
                                        menus: @menuIds, date: rangeDates[0], frame: working_hours[i]), class:'date-link'
                    
                    calender << circle
                    
                #出勤しない時間     'break'とデータベースに指定の時間(working_hours[i])がない。
                else
                    calender << "-"
                end
                
            calender << '</td>'
            
#------------二日目----------------------------------

            calender << '<td>'
                
                #Required_timeに応じたreserved(予約済み時間)の前の時間   必ず "reserved"の上
                if secondDatePRF.include?(working_hours[i])
                    
                    calender << '✖'
                
                #予約済み   
                elsif secondDatesReservedFrames.include?(working_hours[i])
                    
                    calender << '✖'

                #予約不可  RequiredTimeに応じた退勤時間からの処理 ex. 必要時間90分に対して退勤時間から２つ上のカラムを削る
                elsif secondunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: staff, frame: working_hours[i], date: rangeDates[1], frame_status: "available")

                   calender << '-'    
                    
                #予約可   
                elsif secondDatesFrames.include?(working_hours[i])
                    
                    circle = link_to '◎', custamer_detail_reservations_path(selectedStaff: @staff.id,  menu_required_times: @menuRequiredTimes,
                                       menus: @menuIds, date: rangeDates[1], frame: working_hours[i]), class:'date-link'
                    
                    calender << circle
                    
                #出勤しない時間   
                else
                
                    calender << "-"
                end
            
            calender << '</td>'

#-----------3日目-----------------------------

            calender << '<td>'
            
                #Required_timeに応じたreserved(予約済み時間)の前の時間   必ず "reserved"の上
                if thirdDatePRF.include?(working_hours[i])
                 
                    calender << '✖'
            
                #予約済み   
                elsif thirdDatesReservedFrames.include?(working_hours[i])
                    
                    calender << '✖'
                    
                #予約不可  RequiredTimeに応じた退勤時間からの処理 ex. 必要時間90分に対して退勤時間から２つ上のカラムを削る
                elsif thirdunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: staff, frame: working_hours[i], date: rangeDates[2], frame_status: "available")

                   calender << '-'    
                    
                #予約可   
                elsif thirdDatesFrames.include?(working_hours[i])
                
                    circle = link_to '◎', custamer_detail_reservations_path(selectedStaff: @staff.id,menu_required_times: @menuRequiredTimes,
                                        menus: @menuIds, date: rangeDates[2], frame: working_hours[i]), class:'date-link'
                    
                    calender << circle
                   
                #出勤しない時間   
                else
                
                    calender << "-"
                end
            
            calender << '</td>'

#------------4日目------------------------------------

            calender << '<td>'
            
                #Required_timeに応じたreserved(予約済み時間)の前の時間   必ず "reserved"の上
                if fouseDatePRF.include?(working_hours[i])
                 
                    calender << '✖'
                    
                #予約済み   
                elsif fouseDatesReservedFrames.include?(working_hours[i])
                    
                    calender << '✖'
                    
                #予約不可  RequiredTimeに応じた退勤時間からの処理 ex. 必要時間90分に対して退勤時間から２つ上のカラムを削る
                elsif fouseunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: staff, frame: working_hours[i], date: rangeDates[3], frame_status: "available")

                   calender << '-'    
                    
                 #予約可   
                elsif fouseDatesFrames.include?(working_hours[i])
                    circle = link_to '◎', custamer_detail_reservations_path(selectedStaff: @staff.id, menu_required_times: @menuRequiredTimes, 
                                       menus: @menuIds,  date: rangeDates[3], frame: working_hours[i]), class:'date-link'
                    
                    calender << circle
                   
                #出勤しない時間   
                else
                
                    calender << "-"
                end
            
            calender << '</td>'

#------------5日目-------------------------------------------

            calender << '<td>'
            
                #Required_timeに応じたreserved(予約済み時間)の前の時間   必ず "reserved"の上
                if fifthDatePRF.include?(working_hours[i])
                 
                    calender << '✖'
                    
                #予約済み   
                elsif fifthDatesReservedFrames.include?(working_hours[i])
                    
                    calender << '✖'
                    
                #予約不可  RequiredTimeに応じた退勤時間からの処理 ex. 必要時間90分に対して退勤時間から２つ上のカラムを削る
                elsif fifthunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: staff, frame: working_hours[i], date: rangeDates[4], frame_status: "available")

                   calender << '-'    
                    
                #予約可   
                elsif fifthDatesFrames.include?(working_hours[i])
                    
                    circle = link_to '◎', custamer_detail_reservations_path(selectedStaff: @staff.id,  menu_required_times: @menuRequiredTimes, 
                                       menus: @menuIds, date: rangeDates[4], frame: working_hours[i]), class:'date-link'
                    
                    calender << circle
                    
                #出勤しない時間   
                else
                
                    calender << "-"
                end
            
            calender << '</td>'

#------------6日目------------------------------------

            calender << '<td>'
            
                #Required_timeに応じたreserved(予約済み時間)の前の時間   必ず "reserved"の上
                if sixthDatePRF.include?(working_hours[i])
                 
                    calender << '✖'           
            
                #予約済み   
                elsif sixthDatesReservedFrames.include?(working_hours[i])
                    
                    calender << '✖'

                #予約不可  RequiredTimeに応じた退勤時間からの処理 ex. 必要時間90分に対して退勤時間から２つ上のカラムを削る
                elsif sixthunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: staff, frame: working_hours[i], date: rangeDates[5], frame_status: "available")

                   calender << '-'    
                    
                #予約可   
                elsif sixthDatesFrames.include?(working_hours[i])
                    
                    circle = link_to '◎', custamer_detail_reservations_path(selectedStaff: @staff.id, menu_required_times: @menuRequiredTimes, 
                                       menus: @menuIds, date: rangeDates[5], frame: working_hours[i]), class:'date-link'
                    
                    calender << circle
                    
                #出勤しない時間   
                else
                
                    calender << "-"
                end
            
            calender << '</td>'



#-----------7日目------------------------------------


            calender << '<td>'
                
                #Required_timeに応じたreserved(予約済み時間)の前の時間   必ず "reserved"の上
                if seventhDatePRF.include?(working_hours[i])
                 
                    calender << '✖'  
                
                #予約済み   
                elsif seventhDatesReservedFrames.include?(working_hours[i])
                
                    calender << '✖'

                #予約不可  RequiredTimeに応じた退勤時間からの処理 ex. 必要時間90分に対して退勤時間から２つ上のカラムを削る
                elsif seventhunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: staff, frame: working_hours[i], date: rangeDates[6], frame_status: "available")

                   calender << '-'    
                    
                #予約可   
                elsif seventhDatesFrames.include?(working_hours[i])
                    
                    circle = link_to '◎', custamer_detail_reservations_path(selectedStaff: @staff.id, menu_required_times: @menuRequiredTimes, 
                                       menus: @menuIds, date: rangeDates[6], frame: working_hours[i]), class:'date-link'
                                       
                    calender << circle
                    
                #出勤しない時間   
                else
                
                    calender << "-"
                end
            
            calender << '</td>'
            
            
           calender << '</tr>' + "\n"
           
        end  #calender_size
                        
        
        calender << '</tbody>'                
                        
             
        return calender           
    end
   # --------------------private-----------------------------------------------
    
    
    private
    
    # 必要時間に応じた30分単位のカラム数を取得。　そこから -1をして表示を変更するカラム数を求める。　　
    #例　menuRequiredTimes(120)から30で割って4カラム必要となる。そこから表示するのは先頭の1カラムで良いので残り3つは"-"
    
    def calumn(calumn_number)
        toInteger = calumn_number.to_i
        #必要時間30min以下
        if calumn_number < 1   
            
            number_integer = 0
            
        #整数かどうか判定。calumn_numberが30で割り切れた場合　　calumn_number =~ /^[0-22]+$/   
        elsif 0 == calumn_number % toInteger 
        
            number_integer = calumn_number.to_i - 1  #表示を変えなければならいないマスの数がわかる。 １ひく　4ならケツの３カラムを"-"にする。
          
        #Flootの場合。                    
        else  
                            
            number_integer = toInteger
            
        end
        
        return number_integer  
    end
end