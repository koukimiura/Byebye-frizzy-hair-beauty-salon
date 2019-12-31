class Schedule < ApplicationRecord
    require 'date'
    
    validates :staff_id, :frame, :frame_status, presence: true
    validates :date, presence: true#,  uniqueness: true
    
    belongs_to :staff
   
    
end
