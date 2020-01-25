class Schedule < ApplicationRecord
    
    require 'date'
    
    #ストロングパラメータでpermitした属性
    attr_accessor :start_time
    attr_accessor :end_time
    belongs_to :staff

     with_options presence: true do
        validates :staff_id
        validates :frame
        validates :date
        validates :frame_status
    end
    

    
    def self.do_somthing
        
        date = Date.current - 2.months
        first_date = date.beginning_of_month.to_s  #指定した月の初日
        last_date = date.end_of_month.to_s #指定した月の最終日
        
        range = first_date..last_date
        
        return self.destroy(date: range)
        
    end
    
    
    
end
