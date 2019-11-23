class SchedulesController < ApplicationController
    
    
    def new
        logger.debug("----params=#{params[:id]}")
        @current_staff = Staff.find(params[:staff_id])
        @schedule = Schedule.new 
        this_month_first_day = Date.today.beginning_of_month
        next_month = this_month_first_day.next_month
        #logger.debug("-----next_month=#{next_month}")
        @dates = (next_month..next_month.end_of_month)#.map{|date| date.strftime("%m月 %d日")}
    end
    
    
    
    
    def create
        staffId = params[:staff_id]
        date_and_times = params[:date_and_time]
        
        #working_times = ["10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30",
                         #"16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30"]
    
        total_Index = date_and_times.length
        i = 0
        count=[]
        #インデックス番号がしょっぱな０だからtotal_Indexはインデックスの合計数と同じでok
        while i < total_Index do
            grount = date_and_times[i]
            #労働時間用
            end_hour = grount['end_time'].to_f
            start_hour = grount['start_time'].to_f
            #Index用
            end_time = grount['end_time'].to_f
            start_time = grount['start_time'].to_f
            
            index = (end_time-start_time)*2
            #logger.debug("-----index=#{index}")
            dates =[]
            #indexと同じ回数日数を作る。
            index.to_i.times do
                dates << grount['date']
            end
            
            #logger.debug("----dates=#{dates}")
            
            all_hour =[]
            
                until start_hour >= end_hour
                    all_hour << start_hour
                    start_hour += 0.5
                end
            #logger.debug("-----all_times=#{all_times}")
            #returnで少数をstringに
            string_times =all_hour.map{|float_time| time_to_string(float_time)}
            count << { date: dates, working_hour: string_times}
            i +=1
        end
        
        logger.debug("-----count=#{count}")
        
        count_Index=count.length
        
        #while i < count_Index do
            #count.each do |c|
            #c = count[i]
            #d_length= c[:date].length
            #t_length = c[:working_hour].length
            #dates= c[:date]
            #times = c[:working_hour]
            #logger.debug("-----c=#{c}")
                #Schedule.create(staff_id: staffId, date: c[:date], frame: time, frame_status: 'available')
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
            
            #if d_length == t_length
               # i = 0
                #until i > d_length
                    #c[:date].each do |date|
                        #c[:working_hour].each do |time|
                            #Schedule.create(staff_id: staffId, date: dates[i], frame: times[i], frame_status: 'available')
                        #end
                    #end
                    #i +=1
                #end
            #end
            #dates=[]
                #number.times do 
                    #dates.push(d)
                #end
           
            #c[:date].each do |date|
                #c[:working_hour].each do |time|
                    #Schedule.create(staff_id: staffId, date: date, frame: time, frame_status: 'available')
                #end
            #end
            #end
            #end
           # i+=1
        #end
        
        count.each do |value|
            dates=value[:date]
            times= value[:working_hour]
            logger.debug("------dates=#{dates}")
            
            dates.zip(times) do |date, time|
                logger.debug("------date=#{date}")
                logger.debug("------time=#{time}")
                Schedule.create(staff_id: staffId, date: date, frame: time, frame_status: 'available')
            end
        end
        
                   
        redirect_to root_path
    end
    
    
    
    
    private
        def schedule_params
            #params.require(:schedule).permit(:frame_status, :staff_id[], :date[], :frame[])
            #params.require(:schedule).permit(:frame)#:data, :start_time :end_time)
            #params.permit(frame: [start_time][end_time][date])
        end
        
        
        def time_to_string(float_time)  #10:00のコロン型になおす。
            time_integer = float_time.to_i  #整数部分
            if float_time.to_f - time_integer != 0  #少数なら30分、整数なら00
                string_time = time_integer.to_s + ":30"
            else
                string_time = time_integer.to_s + ":00"
            end
            
            return string_time
        end
        
        
end
