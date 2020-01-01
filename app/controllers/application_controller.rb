class ApplicationController < ActionController::Base
 #before_action :basic_auth
 protect_from_forgery with: :exception
    #before_action :basic , if: :production?
  
  
  
  private
  
    #def production?   #プロダクション環境のみで処理する。
       #Rails.env == "production"
    #end
  
    def basic_auth
        authenticate_or_request_with_http_basic do |username, password|
        username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
        end
    end
    
    
    def update_frame_status
        
        time = DateTime.now
        #logger.debug("--------time=#{time}")
        schedules = Schedule.where(frame_status: 'keep')
        
        schedules.each do |schedule|
            if schedule.updated_at
                
                
            end
            
        end
        
    end
  
end
