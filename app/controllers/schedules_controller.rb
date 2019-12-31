class SchedulesController < ApplicationController
 before_action :basic_auth#, if: :production?
 #before_action :correct_staff, only: [:new, :create]
 #before_action :current_staff, only: [:new, :create]
 #before_action :
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
        #logger.debug("----params=#{params[:id]}")
        #@current_staff = Staff.find_by(id: params[:staff_id])
        
        @staffs = Staff.all.order(status: :asc)
        @schedule = Schedule.new 
        
        this_month_first_day = Date.today.beginning_of_month
        next_month = this_month_first_day.next_month
        @dates = (next_month..next_month.end_of_month)  #.map{|date| date.strftime("%m月 %d日")}
    end
    
    
    
    
    def create
        staffId = params[:staff_id]
        date_and_times = params[:date_and_time]
    
        total_Index = date_and_times.length
        i = 0
        count=[]
        #インデックス番号がしょっぱな０だからtotal_Indexはインデックスの合計数と同じでok
        while i < total_Index do
            grount = date_and_times[i]
            # 出勤時間と退勤時間がどちらかが休暇でもう片方が時間が入っている事故をなくすための処理
            if grount['end_time'] == "0.0" &&  grount['start_time'] != '0.0'
                flash[:alert] = '休暇の場合、出勤時間と退勤時間を休暇にしてください。'
                redirect_to :back and return
                
            elsif grount['end_time'] != "0.0" &&  grount['start_time'] == '0.0'
                flash[:alert] = '休暇の場合、出勤時間と退勤時間を休暇にしてください。'
                redirect_to :back and return
            end
            #労働時間用
            end_hour = grount['end_time'].to_f
            start_hour = grount['start_time'].to_f
            #Index用
            end_time = grount['end_time'].to_f
            start_time = grount['start_time'].to_f
            index = (end_time-start_time)*2
            logger.debug("-----index=#{index}")
            dates =[]
            #indexと同じ回数日数を作る。
            # if分でbreakをはじく
            if  index == 0.0
                dates << grount['date']
            else
                index.to_i.times do
                    dates << grount['date']
                end
            end
            #logger.debug("----dates=#{dates}")
            #start_hourとend_hourの間の時間を取得
            all_hour =[]
                #logger.debug("----start_hour=#{start_hour}")
                logger.debug("----end_hour=#{end_hour}")
                
            #条件分で休暇なら０.０をpush
            if start_hour == 0.0 && end_hour ==0.0
                all_hour << 0.0
            else    
                until start_hour >= end_hour + 0.5
                    all_hour << start_hour
                    start_hour += 0.5
                end
            end
                logger.debug("-----all_hour=#{all_hour}")
            #returnで少数をstringに
            string_times =all_hour.map{|float_time| time_to_string(float_time)}
            count << { date: dates, working_hour: string_times}
            i +=1
        end
        
        logger.debug("-----count=#{count}")


        #countをeachで複数個createする。
        count.each do |value|
            dates=value[:date]
            times= value[:working_hour]
                #logger.debug("------dates=#{dates}")
                logger.debug("-----times=#{times}")
                
            #originals.each do |original|
            dates.zip(times) do |date, time|
                logger.debug("------date=#{date}")
                logger.debug("------time=#{time}")
                if time == "0:00"            #休暇なら　frame_statusをbreakにする
                    Schedule.create(staff_id: staffId, date: date, frame: time, frame_status: 'break')
                    
                    logger.debug("------break_date=#{date}")
                    logger.debug("------break_time=#{time}")
                 #elsif original != time   
                    #Schedule.create(staff_id: staffId, date: date, frame: original, frame_status: 'break')
                    
                elsif time == "9:30" || time == "21:00"
                
                    Schedule.create(staff_id: staffId, date: date, frame: time, frame_status: 'preparation_period')
                    logger.debug("------preparation_period_date=#{date}")
                    logger.debug("------preparation_period_time=#{time}")
                
                
                    
                else
                    logger.debug("------available_date=#{date}")
                    logger.debug("------available_time=#{time}")
                    Schedule.create(staff_id: staffId, date: date, frame: time, frame_status: 'available')
                    
                end
            end
        end
        
        redirect_to root_path
        
        #while i < count_Index do
            #c = count[i]
            #d_length= c[:date].length
            #t_length = c[:working_hour].length
            #dates= c[:date]
            #times = c[:working_hour]
            #logger.debug("-----c=#{c}")
            #logger.debug("-----date=#{c[:date]}")
            #logger.debug("-----index=#{c[:index]}")
            #logger.debug("-----working_hour=#{c[:working_hour]}")
            #d = c[:date]
            # number = c[:index].to_i
            #w_hour = c[:working_hour]
            #logger.debug("-----dates=#{dates}")
            #logger.debug("-----times=#{times}")
            #logger.debug("-----number=#{c[:index]}")
            #logger.debug("-----w_hour=#{c[:working_hour]}")
            #dates=[]
                #number.times do 
                    #dates.push(d)
                #end
            #c[:date].each do |date|
                #c[:working_hour].each do |time|
                    #Schedule.create(staff_id: staffId, date: date, frame: time, frame_status: 'available')
                #end
            #end
    end
    
    #直接直書きでurlにパラメータを入れてきた場合
    def correct_staff
        this_month_first_day = Date.today.beginning_of_month
        next_month = this_month_first_day.next_month
        rangeDates = (next_month..next_month.end_of_month)
        
        staff = Staff.find_by(id: params[:staff_id].to_i)
        
        schedules = Schedule.where(staff_id: staff.id, date: rangeDates)  if staff
        #logger.debug("----------------staff.id=#{staff.id}")
    
        
        #url直書きしてstaff.idが存在した場合、一人が同じ月のシフトが複数できてしまう。
        if schedules.present?   
            
            flash[:alert] = '今月のシフトは入力済みです。'
            
            redirect_to login_form_staffs_path
            
        #そもそもstaffが存在しなかったら    
        elsif staff.nil?
        
            flash[:alert] = 'スタッフの情報を入力してください。s'
            
            redirect_to login_form_staffs_path
        
        end
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
        
        
end
