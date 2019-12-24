class Reservation < ApplicationRecord
    
    #serialize :menu_id
    serialize :frames, Array
    
    require "json"
              
    validates :staff_id, presence: true  
    validates :menu_id, presence: true
    #validates :frames, presence: true
    validates :date, presence: true,  uniqueness: true
    validates :last_name, presence: true
    validates :first_name, presence: true
    validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :tel, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true, format: { with: /\A\S+@\S+\.\S+\z/, message: '適切なアドレスを入れてください。'}
    validates :gender, presence: true
    
    belongs_to :staff
    belongs_to :menu
    
    #予約検索
    
    def self.search(search_last_kana, search_first_kana, search_staff, search_date)
        
        return  Reservation.where(date: search_date).where(staff_id: search_staff) unless search_last_kana  || search_first_kana || 
                                                                        search_staff  || search_date 
                                                                                    
        Reservation.where(date: search_date).where(staff_id: search_staff)
                    .where(last_name_kana: search_last_kana).where(first_name_kana:  search_first_kana)
    end
    
    
    
    
    def reservation_params_JSON
        
          reservation_frames =  JSON.parse(params[:frames].to_json)
            
        
        
        return reservation_frames.each { |key, value| logger.debug("-----------配列=#{value}")}
    end
    
    
    
end
    