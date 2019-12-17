module ReservationsHelper

    def reservation_calender(d, staff, menuRequiredTimes)
        logger.debug("-------d=#{d}")
        
        next_week = d - 1 + 1.week
        q = d.beginning_of_month.next_month  #来月のyearとmonth
        
        range = (d..next_week) #一週間分のyear month dateを取得し
        #schedules = Schedule.where(staff_id: 1).where(date: range)

        next_dates=[]
        specified_dates=[]  #今月またはnext_datesの前の月, つまり今月からみた再来月はspcifiedになる。
        
        rangeDates=[]       #range[0]のようにrangeをインデックス 指定して取り出しできないので配列の作り直し。            
        
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
                
                rangeDates << r    #range[0]のようにrangeをインデックス 指定して取り出しできないので配列の作り直し。 .ex 2019-12-12
            end
       # end
        
        
        
        n_dates = next_dates.uniq
        s_dates = specified_dates.uniq
        logger.debug("------s_dates=#{s_dates}")
        logger.debug("------n_dates=#{n_dates}")
        
        
        
        
        specified = "#{s_dates[0].year}年#{s_dates[0].month}月" #指定された月
    
        #Float化して少数点まで求める。    menuRequiredTimesは選択されたメニューの時間
        calumn_number = menuRequiredTimes.to_f / 30 #- 1
        
        logger.debug("----------menuRequiredTimes.to_i=#{menuRequiredTimes.to_f}")
        
        staffSchedules = Schedule.where(staff_id: 1, date: range).where.not(frame_status: "preparation_period")
        
        
        
        
        
        
        
        
        
        
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
                #mixed_dates = s_dates | n_dates   #配列をまとめる
                
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

        

        #------------予約カレンダーアルゴリズム(処理)----------------------------------------------------------------
        
        calender << '<tbody>'
        
        #カレンダーのマス個数決め   あくまで予約時間　9:30と21:00は準備　preparation period
        working_hours = ["10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
                        "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30"]
             
             
         #その日の出勤時間が出る。  予約可か予約済みかで配列分ている。             
        firstDatesFrames=[]
        firstDatesReservedFrames=['15:00', '18:00', '18:30']
        
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
            
            logger.debug("------schedule.frame_status=#{schedule.frame_status}")
            #logger.debug("---------schedule.frame=#{Time.parse(schedule.frame)}")
            
            date = Date.parse(schedule.date) #parseで文字列を直す。
            logger.debug("---------date=#{date}")
            case date 
                
                when rangeDates[0] then
                    #logger.debug("-------schedule.frame=#{schedule.frame}")
                    firstDatesFrames.push(schedule.frame) if schedule.frame_status == 'available'  #||  schedule.frame_status == 'break'
                    
                    firstDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'pre-reserved'
                    
                    
                when rangeDates[1] then
                    
                    secondDatesFrames.push(schedule.frame) if schedule.frame_status == 'available' # ||  schedule.frame_status == 'break'
                    
                    secondDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'pre-reserved'
                    
                when rangeDates[2] then

                    thirdDatesFrames.push(schedule.frame)  if schedule.frame_status == 'available' # ||  schedule.frame_status == 'break'
                    
                    thirdDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'pre-reserved'

                when rangeDates[3] then
                    
                    fouseDatesFrames.push(schedule.frame) if schedule.frame_status == 'available'  #||  schedule.frame_status == 'break'
                    
                    fouseDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'pre-reserved'
                    
                when rangeDates[4] then
                    
                    fifthDatesFrames.push(schedule.frame) if schedule.frame_status == 'available' # ||  schedule.frame_status == 'break'
                    
                    fifthDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'pre-reserved'
                    
                when rangeDates[5] then
                    
                    sixthDatesFrames.push(schedule.frame) if schedule.frame_status == 'available'  #||  schedule.frame_status == 'break'
                    
                    sixthDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'pre-reserved'
                    
                when rangeDates[6] then  
                    
                    seventhDatesFrames.push(schedule.frame) if schedule.frame_status == 'available'  #||  schedule.frame_status == 'break'
                    
                    seventhDatesReservedFrames.push(schedule.frame) if schedule.frame_status == 'reserved' || schedule.frame_status == 'pre-reserved'
                    
            end
        end
   
   
   
        
#-------初日----------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        firstDatePreviousReservedFrames=[]
        
        #working_hours.zip(firstDatesReservedFrames) do | whour, f|
        firstDatesReservedFrames.each do |f|
            #until Time.parse(whour) < Time.parse(f)
            
                #firstDate_before_reserved_times.push(whour)
                previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(f) }
                #previousTimes = working_hours.find{ |whour| Time.parse(whour) < Time.parse(f) }
                logger.debug("----------previousTimes=#{previousTimes}")
                
                                                                #calumnメソッドを呼び出す。これは取得する要素数
                firstDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
              
            #end
        end

        logger.debug("----------firstDatePreviousReservedFrames=#{firstDatePreviousReservedFrames}")
        
        #二次元配列を一次元配列に直す。
        firstDatePRF=[]
        
        #firstDatePreviousReservedFrames.each_with_index do |v, idx|
        
        firstDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                firstDatePRF << x
            end
        end
     
        logger.debug("--------------firstDatePRF=#{firstDatePRF}")
        
 
#-------2日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        secondDatePreviousReservedFrames=[]
        
        #working_hours.zip(firstDatesReservedFrames) do | whour, f|
        secondDatesReservedFrames.each do |s|
            #until Time.parse(whour) < Time.parse(f)
            
                #firstDate_before_reserved_times.push(whour)
                previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(s) }
                #previousTimes = working_hours.find{ |whour| Time.parse(whour) < Time.parse(f) }
                logger.debug("----------previousTimes=#{previousTimes}")
                
                                                                #calumnメソッドを呼び出す。これは取得する要素数
                secondDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
              
            #end
        end

        logger.debug("----------secondDatePreviousReservedFrames=#{secondDatePreviousReservedFrames}")
        
        #二次元配列を一次元配列に直す。
        secondDatePRF=[]
        
        #firstDatePreviousReservedFrames.each_with_index do |v, idx|
        
        secondDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                secondDatePRF << x
            end
        end
     
        logger.debug("--------------fsecondDatePRF=#{secondDatePRF}")
 
#-------3日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        thirdDatePreviousReservedFrames=[]
        
        #working_hours.zip(firstDatesReservedFrames) do | whour, f|
        thirdDatesReservedFrames.each do |t|
            #until Time.parse(whour) < Time.parse(f)
            
                #firstDate_before_reserved_times.push(whour)
                previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(t) }
                #previousTimes = working_hours.find{ |whour| Time.parse(whour) < Time.parse(f) }
                logger.debug("----------previousTimes=#{previousTimes}")
                
                                                                #calumnメソッドを呼び出す。これは取得する要素数
                thirdDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
              
            #end
        end

        logger.debug("----------thirdDatePreviousReservedFrames=#{thirdDatePreviousReservedFrames}")
        
        #二次元配列を一次元配列に直す。
        thirdDatePRF=[]
        
        #firstDatePreviousReservedFrames.each_with_index do |v, idx|
        
        thirdDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                thirdDatePRF << x
            end
        end
     
        logger.debug("--------------thirdDatePRF=#{thirdDatePRF}")
 
 
#-------4日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        fouseDatePreviousReservedFrames=[]
        
        #working_hours.zip(firstDatesReservedFrames) do | whour, f|
        fouseDatesReservedFrames.each do |f|
            #until Time.parse(whour) < Time.parse(f)
            
                #firstDate_before_reserved_times.push(whour)
                previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(f) }
                #previousTimes = working_hours.find{ |whour| Time.parse(whour) < Time.parse(f) }
                logger.debug("----------previousTimes=#{previousTimes}")
                
                                                                #calumnメソッドを呼び出す。これは取得する要素数
                fouseDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
              
            #end
        end

        logger.debug("----------fouseDatePreviousReservedFrames=#{fouseDatePreviousReservedFrames}")
        
        #二次元配列を一次元配列に直す。
        fouseDatePRF=[]
        
        #firstDatePreviousReservedFrames.each_with_index do |v, idx|
        
        fouseDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                fouseDatePRF << x
            end
        end
     
        logger.debug("--------------fouseDatePRF=#{fouseDatePRF}")
        
        
#-------5日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        fifthDatePreviousReservedFrames=[]
        
        #working_hours.zip(firstDatesReservedFrames) do | whour, f|
        fifthDatesReservedFrames.each do |f|
            #until Time.parse(whour) < Time.parse(f)
            
                #firstDate_before_reserved_times.push(whour)
                previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(f) }
                #previousTimes = working_hours.find{ |whour| Time.parse(whour) < Time.parse(f) }
                logger.debug("----------previousTimes=#{previousTimes}")
                
                                                                      #calumnメソッドを呼び出す。これは取得する要素数
                fifthDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
              
            #end
        end

        logger.debug("----------fifthDatePreviousReservedFrames=#{fifthDatePreviousReservedFrames}")
        
        #二次元配列を一次元配列に直す。
        fifthDatePRF=[]
        
        #firstDatePreviousReservedFrames.each_with_index do |v, idx|
        
        fifthDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                fifthDatePRF << x
            end
        end
     
        logger.debug("--------------fifthDatePRF=#{fifthDatePRF}")
        
        
#-------6日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        sixthDatePreviousReservedFrames=[]
        
        #working_hours.zip(firstDatesReservedFrames) do | whour, f|
        sixthDatesReservedFrames.each do |f|
            #until Time.parse(whour) < Time.parse(f)
            
                #firstDate_before_reserved_times.push(whour)
                previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(f) }
                #previousTimes = working_hours.find{ |whour| Time.parse(whour) < Time.parse(f) }
                logger.debug("----------previousTimes=#{previousTimes}")
                
                                                                    #calumnメソッドを呼び出す。これは取得する要素数
                sixthDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
              
            #end
        end

        logger.debug("----------sixthDatePreviousReservedFrames=#{sixthDatePreviousReservedFrames}")
        
        #二次元配列を一次元配列に直す。
        sixthDatePRF=[]
        
        #firstDatePreviousReservedFrames.each_with_index do |v, idx|
        
        sixthDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                sixthDatePRF << x
            end
        end
     
        logger.debug("--------------sixthDatePRF=#{sixthDatePRF}")
        
         
#-------7日目------------------------------------------------------------------------
        
        #配列の中に配列入ってます（二次元配列）。一度selectを使って配列を作っているので....
        seventhDatePreviousReservedFrames=[]
        
        #working_hours.zip(firstDatesReservedFrames) do | whour, f|
        seventhDatesReservedFrames.each do |s|
            #until Time.parse(whour) < Time.parse(f)
            
                #firstDate_before_reserved_times.push(whour)
                previousTimes = working_hours.select{ |whour| Time.parse(whour) < Time.parse(s) }
                #previousTimes = working_hours.find{ |whour| Time.parse(whour) < Time.parse(f) }
                logger.debug("----------previousTimes=#{previousTimes}")
                
                                                                    #calumnメソッドを呼び出す。これは取得する要素数
                seventhDatePreviousReservedFrames << previousTimes.last(calumn(calumn_number))
              
            #end
        end

        logger.debug("----------seventhDatePreviousReservedFrames=#{seventhDatePreviousReservedFrames}")
        
        #二次元配列を一次元配列に直す。
        seventhDatePRF=[]
        
        #firstDatePreviousReservedFrames.each_with_index do |v, idx|
        
        seventhDatePreviousReservedFrames.each do | v |  
            v.each do |x|
                firstDatePRF << x
            end
        end
     
        logger.debug("--------------seventhDatePRF=#{seventhDatePRF}")
        
        
        
        
        
        
        
        
         #配列から"-"分のカラム数に対応する配列の要素を取得
         #退勤時間からcalumn_number数分表示をかえる。
                                    
         firstunavailableCalumns = firstDatesFrames.last(calumn(calumn_number))
         secondunavailableCalumns = secondDatesFrames.last(calumn(calumn_number))
         thirdunavailableCalumns = thirdDatesFrames.last(calumn(calumn_number))
         fouseunavailableCalumns = fouseDatesFrames.last(calumn(calumn_number))
         fifthunavailableCalumns = fifthDatesFrames.last(calumn(calumn_number))
         sixthunavailableCalumns = sixthDatesFrames.last(calumn(calumn_number))
         seventhunavailableCalumns = seventhDatesFrames.last(calumn(calumn_number))
         
         #logger.debug("----------calumn_number=#{calumn_number}")
         #logger.debug("-------------firstDatesFrames=#{firstDatesFrames}")
         #logger.debug("--------firstunavailableCalumns=#{firstunavailableCalumns}")
         
    
         

        #------------viewに出ている処理。まる、バツ、ハイフンはここで作ってます。--------------------
        
        calender_size = working_hours.length* 7
       
        #マスの数を一週間でわる　i= 0から21まで
        (calender_size/7).times do |i|
            calender << "\t" + '<tr>'
            
            hour = working_hours[i]
            
            calender << '<td>'
            
            calender << hour
            
            calender <<'</td>' 
            
        
#------------初日-----------------------------------------------------------------   

            calender << '<td>'
                 
                #Required_timeに応じたreservedの前の時間   必ず "reserved"の上
                if firstDatePRF.include?(working_hours[i])
                 
                    calender << '✖'
                 
                 
                #予約済み    frame_status: "reserved" または　pre-reserved
                
                elsif firstDatesReservedFrames.include?(working_hours[i])
                #if  Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[0], frame_status: "reserved")

                    calender << '✖'


                
                #予約不可  RequiredTimeに応じた退勤時間からの処理  
                elsif firstunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[0], frame_status: "available")

                   calender << '-'    
                    
                    
                    
                #予約可    firstDatesFrames.include?(working_hours[i])  frame_status: 'avaiable'
                elsif firstDatesFrames.include?(working_hours[i])
                #elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[0], frame_status: "available")                    
                    
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
                
                
                if secondDatePRF.include?(working_hours[i])
                    
                    calender << '✖'
                
                
                #予約済み   
                #if  Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[1], frame_status: "reserved")
                elsif secondDatesReservedFrames.include?(working_hours[i])
                    
                    calender << '✖'

                    
                #予約不可
                elsif secondunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[1], frame_status: "available")

                   calender << '-'    
                    
                    
                    
                #予約可   
                #elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[1], frame_status: "available")  
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
            
                #Required_timeに応じたreservedの前の時間   
                if thirdDatePRF.include?(working_hours[i])
                 
                    calender << '✖'
            
            
                #予約済み   
                #if  Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[2], frame_status: "reserved")
                elsif thirdDatesReservedFrames.include?(working_hours[i])
                    
                    calender << '✖'

                    
                #予約不可
                elsif thirdunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[2], frame_status: "available")

                   calender << '-'    
                    
                    
                    
                #予約可   
                #elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[2], frame_status: "available")                    
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
            
                #Required_timeに応じたreservedの前の時間   
                if fouseDatePRF.include?(working_hours[i])
                 
                    calender << '✖'
                    
                    
                    
                #予約済み   
                #if  Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[3], frame_status: "reserved")
                elsif fouseDatesReservedFrames.include?(working_hours[i])
                    
                    
                    calender << '✖'

                    
                #予約不可
                elsif fouseunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[3], frame_status: "available")

                   calender << '-'    
                    
                    
                    
                 #予約可   
                #elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[3], frame_status: "available")                    
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
            
                #Required_timeに応じたreservedの前の時間   
                if fifthDatePRF.include?(working_hours[i])
                 
                    calender << '✖'
                    
        
                #予約済み   
                #if  Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[4], frame_status: "reserved")
                elsif fifthDatesReservedFrames.include?(working_hours[i])
                    
                    calender << '✖'

                    
                #予約不可
                elsif fifthunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[4], frame_status: "available")

                   calender << '-'    
                    
                    
                    
                #予約可   
                #elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[4], frame_status: "available") 
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
            
                #Required_timeに応じたreservedの前の時間   
                if sixthDatePRF.include?(working_hours[i])
                 
                    calender << '✖'           
            
            
                #予約済み   
                #if  Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[5], frame_status: "reserved")
                elsif sixthDatesReservedFrames.include?(working_hours[i])
                    
                    calender << '✖'

                    
                #予約不可
                elsif sixthunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[5], frame_status: "available")

                   calender << '-'    
                    
                    
                    
                #予約可   
                #elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[5], frame_status: "available")
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
                
                
                #Required_timeに応じたreservedの前の時間   
                if seventhDatePRF.include?(working_hours[i])
                 
                    calender << '✖'  
                
                
                #予約済み   
                #if  Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[6], frame_status: "reserved")
                elsif seventhDatesReservedFrames.include?(working_hours[i])
                
                    calender << '✖'

                    
                #予約不可
                elsif seventhunavailableCalumns.include?(working_hours[i]) && Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[6], frame_status: "available")

                   calender << '-'    
                    
                    
                #予約可   
                #elsif Schedule.find_by(staff_id: 1, frame: working_hours[i], date: rangeDates[6], frame_status: "available")
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
        logger.debug("-------calumn_number=#{calumn_number}")
        logger.debug("-------toInteger=#{toInteger}")
        
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
        
        logger.debug("--------number_integer=#{number_integer}")
        return number_integer  
    end
end