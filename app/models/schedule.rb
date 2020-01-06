class Schedule < ApplicationRecord
    
    require 'date'
    
    #ストロングパラメータでpermitした属性
    attr_accessor :start_time
    attr_accessor :end_time
    
    #attr_accessor :number
    #attr_accessor :dateKey

    
    
    
    validates :staff_id, :frame, :frame_status, :date, presence: true

    belongs_to :staff
   
   
   
    
    def self.do_somthing
        
        date = Date.today - 2.months
        first_date = date.beginning_of_month.to_s  #指定した月の初日
        last_date = date.end_of_month.to_s #指定した月の最終日
        
        range = first_date..last_date
        
        return self.destroy(date: range)
        
    end
    
    
    
end
