class Reservation < ApplicationRecord
    
    #serialize :menu_id
    #serialize :frames, Array
    
    require "json"
    
    belongs_to :staff
    # require trueがつく可能性が高い
    #belongs_to :menu
              
    #validates :staff_id, presence: true  
    #validates :menu_ids, presence: true
    #validates :frames, presence: true
    #validates :date, presence: true
    #validates :last_name, presence: true
    #validates :gender, presence: true
    #validates :first_name, presence: true
    #validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    #validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    #validates :tel, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}-[0-9]{4}\z/, message: '電話番号はハイフンなしです。'}
    #validates :email, presence: true, format: { with: /\A\S+@\S+\.\S+\z/, message: '適切なアドレスを入れてください。'}
    
    
    
    
    #予約検索
    def self.search(search_last_kana, search_first_kana, search_staff, search_date)
        
        return  Reservation.where(date: search_date).where(staff_id: search_staff) unless search_last_kana  || search_first_kana || 
                                                                        search_staff  || search_date 
                                                                                    
        Reservation.where(date: search_date).where(staff_id: search_staff)
                    .where(last_name_kana: search_last_kana).where(first_name_kana:  search_first_kana)
    end

end
    