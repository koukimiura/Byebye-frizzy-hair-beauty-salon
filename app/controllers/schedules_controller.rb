class SchedulesController < ApplicationController
 before_action :basic_auth, if: :production?
 before_action :schedules_check, only: [:create]


    def index
        @before = Date.today - 1.months
        @present = Date.today
        @after = Date.today + 1.months
    end
    

    def date_workers
        if params[:date]                                    #出勤者だけとってくる。
            schedules = Schedule.where(date: params[:date]).where.not(frame_status: "break")
            
            staffs=[]
            
            schedules.each do |schedule|
                staffs.push(Staff.find(schedule.staff_id))
            end
            
            @uniq_staffs = staffs.uniq   #staff_id一つに対して、dateが多いのでuniqをかけてstaffの重複を防ぐ。
        end
    end
    
    
    
    def new
        @staffs = Staff.all.order(status: :asc)
        @schedule = Schedule.new 
        
        #this_month_first_day = Date.today.beginning_of_month
        #next_month = this_month_first_day.next_month
        #@dates = (next_month..next_month.end_of_month)  #.map{|date| date.strftime("%m月 %d日")}
        
        #rangeDate   pravateメソッドから呼び出し
        @dates = rangeDate  
        
        
        
        
    end
    

    
    def create
        
        #@schedule = Schedule.new(schedule_params)
        #logger.debug("--------------schedule_params=#{schedule_params}")
        
        date_and_times=[]
        
        schedule_params[:date].each do |d|
            schedule_params[:start_time].each do |s|
                schedule_params[:end_time].each do |e|
                    
                    if d[:number] == s[:number] && d[:number] == e[:number] && s[:number] == e[:number]
                        
                        date_and_times << {:date => d[:dateKey], :start_time => s[:frame], :end_time => e[:frame]}
                        
                    end
                end
            end
        end

        total_Index = date_and_times.length

        i = 0
        count=[]
        
        #インデックス番号がしょっぱな０だからtotal_Indexはインデックスの合計数と同じでok
        #total_Indexは来月の日数
        
        while i < total_Index do
            
            grount = date_and_times[i]

            # 出勤時間と退勤時間がどちらかが休暇でもう片方が時間が入っている事故をなくすための処理
            if grount[:end_time] == "0.0" &&  grount[:start_time] != '0.0'
                flash[:alert] = '休暇の場合、出勤時間と退勤時間を休暇にしてください。'
                redirect_to :back and return
                #render :new and return
                
            elsif grount[:end_time] != "0.0" &&  grount[:start_time] == '0.0'
                flash[:alert] = '休暇の場合、出勤時間と退勤時間を休暇にしてください。'
                redirect_to :back and return
                #render :new and return
            end
            
            #労働時間用
            end_hour = grount[:end_time].to_f
            start_hour = grount[:start_time].to_f
            
            #Index用
            end_time = grount[:end_time].to_f
            start_time = grount[:start_time].to_f
            
            index = (end_time-start_time)*2
            

            dates =[]
            #indexと同じ回数日数を作る。
            # if文でbreakをはじく
            
            if  index == 0.0     #break
                dates << grount[:date]
            else
                
                index.to_i.times do
                    dates << grount[:date]
                end
                
            end
            #start_hourとend_hourの間の時間を取得
            all_hour =[]

            #条件分で休暇なら０.０をpush
            if start_hour == 0.0 && end_hour ==0.0
                all_hour << 0.0
            else    
                until start_hour >= end_hour + 0.5
                    all_hour << start_hour
                    start_hour += 0.5
                end
            end
            #returnで少数をstringに
            string_times =all_hour.map{|float_time| time_to_string(float_time)}
            count << { date: dates, working_hour: string_times}
            i +=1
        end


#-------------create----------------------

        #countをeachで複数個createする。
        count.each do |value|
            dates=value[:date]
            times= value[:working_hour]

                
            dates.zip(times) do |date, time|
                #logger.debug("------original_date=#{date}")
                #logger.debug("------original_time=#{time}")
                
                if time == "0:00"            #休暇なら　frame_statusをbreakにする
                
                    Schedule.create(staff_id: schedule_params[:staff_id], date: date, frame: time, frame_status: 'break')
                    
                    logger.debug("------break_date=#{date}")
                    logger.debug("------break_time=#{time}")
                    

                elsif time == "9:30" || time == "21:00"
                
                    Schedule.create(staff_id: schedule_params[:staff_id], date: date, frame: time, frame_status: 'preparation_period')
                    
                    logger.debug("------preparation_period_date=#{date}")
                    logger.debug("------preparation_period_time=#{time}")
                
                
                    
                else
                    #退勤時間を18:00にしても予約するときはavailable_timeの最後は17:30で入る。そのため18:00(退勤時間)はscheduleのDBには存在しない。
                    logger.debug("------available_date=#{date}")
                    logger.debug("------available_time=#{time}")
                    
                    Schedule.create(staff_id: schedule_params[:staff_id], date: date, frame: time, frame_status: 'available')
                    
                end
            end
        end
        redirect_to home_basic_path
    end
    


    private
        
        #少数とstringに戻すアルゴリズム
        def time_to_string(float_time)  #10:00のコロン型になおす。
            time_integer = float_time.to_i  #整数部分
        
            if float_time.to_f - time_integer != 0  #少数なら30分、整数なら00
                string_time = time_integer.to_s + ":30"
            else
                string_time = time_integer.to_s + ":00"  #休暇でも　"0:00"の形で返す。
            end

            return string_time
        end
        
        
        def schedules_check
            
            staff = Staff.find_by(id: schedule_params[:staff_id])
                
            if staff.nil?
                
                flash[:alert] = 'スタッフを選択してください。'
                redirect_to schedules_new_path
            
             elsif  Schedule.where(date: rangeDate, staff_id: staff.id).present?
                
                flash[:alert] = '選択されたスタッフのシフトはすでに組まれています。'
                redirect_to home_basic_path
            
            end
            
        end
        
        
        def rangeDate
            this_month_first_day = Date.today.beginning_of_month
            next_month = this_month_first_day.next_month
            
            #rangeDate   pravateメソッドないから呼び出し
            return (next_month..next_month.end_of_month)
            
        end
        
        
    
        def schedule_params
            #一回配列がネストするパターン
            
            params.require(:schedule).permit(:staff_id, :date => [:number, :dateKey], 
                                                        :start_time => [:number, :frame], 
                                                        :end_time => [:number, :frame]
                                                        )
        end
end
