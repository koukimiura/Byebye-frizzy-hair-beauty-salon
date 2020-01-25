class ApplicationController < ActionController::Base
 #before_action :basic_auth
 protect_from_forgery with: :exception
 before_action :update_frame_status
 #before_action :japanese_time
  
  
  private
  
    #プロダクション環境のみで処理する。
    
    def production?  
       Rails.env == "production"
    end
  
    def basic_auth
        authenticate_or_request_with_http_basic do |username, password|
        username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
        end
    end
    
    #keepを30分後updateする。
    def update_frame_status
        
        schedules = Schedule.where(frame_status: 'keep')
        
        #グリンリッジ
        time = Time.now   # + 5.days 
        

        schedules.each do |schedule|
            #logger.debug("--------schedule.updated_at =#{schedule.updated_at}")
            #15分足す。
            after_15min =  schedule.updated_at + 900
             
            #logger.debug("--------グリンリッジ=#{time}")
            #logger.debug("--------target..=#{Time.parse(after_30min.to_s)}")
                
             #Time.parse　string化しなさい。
             #update時間の30g後の時間が現在時刻より小さくなったら
            if Time.parse(after_15min.to_s) < time
                
                schedule.update_attributes(frame_status: 'available')
                
            end#if
        end#each
    end#update_frame_status
        
        
end
