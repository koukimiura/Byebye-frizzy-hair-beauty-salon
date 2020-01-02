class Schedule < ApplicationRecord
    
    require 'date'
    
    validates :staff_id, :frame, :frame_status, :date, presence: true

    belongs_to :staff
   
   
   
    
    def self.do_somthing
        
        date = Date.today - 2.months
        first_date = Date.new(date 1) #指定した月の初日
        last_date = Date.new(date -1) #指定した月の最終日
        
        range = first_date..last_date
        
        return self.destroy(date: range)
        
    end
    
    
    
end
