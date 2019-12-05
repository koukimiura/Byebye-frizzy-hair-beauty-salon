module SchedulesHelper

    def make_calender_before(before)
        
        @date = before.strftime("%Y年 %m月")
        year = before.year
        month = before.month 
        
        first_date = Date.new(year, month, 1) #指定した月の初日
        last_date = Date.new(year, month, -1) #指定した月の最終日
        #logger.debug("------first_date=#{first_date}")
        #logger.debug("------last_date=#{last_date}")

        range=(first_date..last_date)  #今月の日数を配列化

        calender_size = last_date.day + first_date.wday - last_date.wday + 6 
        #テーブルのカラム数(ここでのカラムはカレンダーのマス目の数)を保存
        

        calender = '' #returnされる。 #calender << の受け取り先
        
        calender << '<table border=1 bordercolor= ##DDDDDD>'  + "\n"
        calender <<  @date
        calender << '<tr><td>日</td><td>月</td><td>火</td><td>水</td><td>木</td><td>金</td><td>土</td></tr>'
        #曜日
        
        (calender_size/7).times do |n|                              #縦の５を取得  nを5回まわす。
            calender << "\t" + '<tr>'                               #カレンダーの段落数。
                                                                    #横の７を取得　（一週間)
            7.times do |i|                                          #timesとブロックiだと0~6の変数を入れてくれる。
                cal_count = n*7 + i                                 #nは0〜４を各数字7回まわす。
                calender << '<td>'
                #下記が必要となる日付を撮ってくる。
                #link = link_to (cal_count - first_date.wday + 1), schedules_date_index_path if first_date.wday <= cal_count && last_date.day > cal_count - first_date.wday
                hennsuu = (cal_count - first_date.wday + 1) if first_date.wday <= cal_count && last_date.day > cal_count - first_date.wday
                
                #先月の最終日が今月の第1週とかぶっていた場合空の<td></td>が表示される。
                
                    if hennsuu == nil
                        calender << hennsuu.to_s                        #calenderにそのまま出す。
                    else
                        range.each do |r|
                            if  r.day == hennsuu
                                    link = link_to hennsuu, schedules_date_workers_path(date: r)    #hennsuuをlink化する。date_workersにて
                                    calender << link.to_s                                           #paramsで受け取る。
                            end
                        end
                    end
                    
                calender << '</td>'
            end
            
            calender << '</tr>'  + "\n"
        end
        
        return calender
    end
    
    
    
    def make_calender_present(present) #今月
        @date = present.strftime("%Y年 %m月")
        year = present.year
        month = present.month 
        
        first_date = Date.new(year, month, 1) #指定した月の初日
        last_date = Date.new(year, month, -1) #指定した月の最終日
        
        range=(first_date..last_date)  #今月の日数を配列化

        #stringだと日数がめちゃくちゃ入る。
        #first = first_date.strftime("%m月 %d日")
        #last = last_date.strftime("%m月 %d日")
        
        calender_size = last_date.day + first_date.wday - last_date.wday + 6 
        #テーブルのカラム数(ここでのカラムはカレンダーのマス目の数)を保存
        
        calender = '' #returnされる。 #calender << の受け取り先
        calender << '<table border=1 bordercolor= ##DDDDDD>'  + "\n"
        calender <<  @date
        calender << '<tr><td>日</td><td>月</td><td>火</td><td>水</td><td>木</td><td>金</td><td>土</td></tr>' #曜日

        #logger.debug("-----calender_size=#{calender_size}")
        
        (calender_size/7).times do |n|                              #縦の５を取得  nを5回まわす。
            calender << "\t" + '<tr>'                               #カレンダーの段落数。
                                                                    #横の７を取得　（一週間)
            7.times do |i|                                          #timesとブロックiだと0~6の変数を入れてくれる。
                cal_count = n*7 + i                                 #nは0〜４を各数字7回まわす。
                calender << '<td>'
                #下記が必要となる日付を撮ってくる。
                #link = link_to (cal_count - first_date.wday + 1), schedules_date_index_path if first_date.wday <= cal_count && last_date.day > cal_count - first_date.wday
                hennsuu = (cal_count - first_date.wday + 1) if first_date.wday <= cal_count && last_date.day > cal_count - first_date.wday
                
                #先月の最終日が今月の第1週とかぶっていた場合空の<td></td>が表示される。
                
                    if hennsuu == nil
                        calender << hennsuu.to_s                        #calenderにそのまま出す。
                    else
                        range.each do |r|
                            if  r.day == hennsuu
                                    link = link_to hennsuu, schedules_date_workers_path(date: r)    #hennsuuをlink化する。date_workersにて
                                    calender << link.to_s                                           #paramsで受け取る。
                            end
                        end
                    end
                    
                calender << '</td>'
            end
            
            calender << '</tr>'  + "\n"
        end
        
        return calender
    end
    
    
    def make_calender_after(after)
        
        @date = after.strftime("%Y年 %m月")
        year = after.year
        month = after.month 
        
        first_date = Date.new(year, month, 1) #指定した月の初日
        last_date = Date.new(year, month, -1) #指定した月の最終日
        
        range=(first_date..last_date)  #今月の日数を配列化

        
        calender_size = last_date.day + first_date.wday - last_date.wday + 6 
        #テーブルのカラム数(ここでのカラムはカレンダーのマス目の数)を保存
        
        calender = '' #returnされる。 #calender << の受け取り先
        calender << '<table border=1 bordercolor= ##DDDDDD>'  + "\n"
        calender <<  @date
        calender << '<tr><td>日</td><td>月</td><td>火</td><td>水</td><td>木</td><td>金</td><td>土</td></tr>' #曜日
        
        
        (calender_size/7).times do |n|                              #縦の５を取得  nを5回まわす。
            calender << "\t" + '<tr>'                               #カレンダーの段落数。
                                                                    #横の７を取得　（一週間)
            7.times do |i|                                          #timesとブロックiだと0~6の変数を入れてくれる。
                cal_count = n*7 + i                                 #nは0〜４を各数字7回まわす。
                calender << '<td>'
                #下記が必要となる日付を撮ってくる。
                #link = link_to (cal_count - first_date.wday + 1), schedules_date_index_path if first_date.wday <= cal_count && last_date.day > cal_count - first_date.wday
                hennsuu = (cal_count - first_date.wday + 1) if first_date.wday <= cal_count && last_date.day > cal_count - first_date.wday
                
                #先月の最終日が今月の第1週とかぶっていた場合空の<td></td>が表示される。
                
                    if hennsuu == nil
                        calender << hennsuu.to_s                        #calenderにそのまま出す。
                    else
                        range.each do |r|
                            if  r.day == hennsuu
                                    link = link_to hennsuu, schedules_date_workers_path(date: r)    #hennsuuをlink化する。date_workersにて
                                    calender << link.to_s                                           #paramsで受け取る。
                            end
                        end
                    end
                    
                calender << '</td>'
            end
            
            calender << '</tr>'  + "\n"
        end
        
        return calender
    end
end