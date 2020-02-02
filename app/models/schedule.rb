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
    
    
    scope :date, ->(d) { where(date: d) }
    
    scope :notBreaking, -> {where.not(frame_status: "break")}
    
    
    #where(staff_id: staffId_params).where(date: Date.current).where(frame_status: "available")
    #reservation.controllerのupdate_passedTimes
    scope :current, -> { where(date: Date.current) }
    
    scope :available, -> { where(frame_status: "available") }

    
    
    
    #where(staff_id: staff, date: range).where.not(frame_status: "preparation_period")
    
    #reservations_helperに書いた line 50--------------------
    
    scope :searchStaff, -> (staff) { where(staff_id: staff) }
    
    scope :searchRangeDate, -> (range)  {where(date: range) }
    
    scope :notPreparation_period, -> {where.not(frame_status: "preparation_period")}
    
    #------------------------------------------------------
    
end
