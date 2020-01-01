class Schedule < ApplicationRecord
    require 'date'
    
    validates :staff_id, :frame, :frame_status, presence: true
    validates :date, presence: true#,  uniqueness: true
    
    belongs_to :staff
   
    
    def self.do_somthing
        
        date = Date.today - 2.months
        first_date = Date.new(date 1) #指定した月の初日
        last_date = Date.new(date -1) #指定した月の最終日
        
        range = first_date..last_date
        
        return self.destroy(date: range)
        
    end
    
     #def self.change_frame_status
        
        #schedules = self.where(frame_status: 'keep')
        
        #return schedules.update(frame_status: 'available')
        
    #end
    
end
