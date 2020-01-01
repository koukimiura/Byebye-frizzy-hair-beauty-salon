class HomeController < ApplicationController
  
  #before_action :basic_auth, only: [:basic] #, if: :production?
  #before_action :require_login, only: [:new, :create]
  before_action :basic_auth, only: [:basic]
  
  def top
    
  end
  
  def basic
    
    #def update_frame_status
        
        time = DateTime.now
        logger.debug("--------time=#{time}")
        schedules = Schedule.where(frame_status: 'keep')
        
        schedules.each do |schedule|
          #３０分足す。
         update_time =  schedule.updated_at + 1800
         logger.debug("-----------update_time=#{update_time}")
            if time <= update_time
                
                
                logger.debug("-----------schedule.updated_at=#{ssss}")
                
            end
            
        end
        
    #end
  end
end
