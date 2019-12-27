class Reservation < ApplicationRecord
    
    #serialize :menu_id
    #serialize :frames, Array
    
    require "json"
    
    belongs_to :staff
    # require trueがつく可能性が高い
    #belongs_to :menu     配列で入れてる
              
    #validates :staff_id, presence: true  
    #validates :menu_ids, presence: true
    #validates :frames, presence: true
    #validates :date, presence: true
    #validates :last_name, presence: true
    #validates :gender, presence: true
    #validates :first_name, presence: true
    #validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    #validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :tel, presence: true#, format: {with: /\A[0-9]{3}-[0-9]{4}-[0-9]{4}\z/, message: '電話番号はハイフンなしです。'}
    validates :email, presence: true#, format: { with: /\A\S+@\S+\.\S+\z/, message: '適切なアドレスを入れてください。'}
    
    
    
    
    #予約検索
    
    #クラスメソッド、　Reservation.searchってこと
    def self.search(search_tel, search_date, dates)
            
        return  Reservation.where(date: dates) unless search_tel || search_date #今日以降のデータ       
        
                Reservation.where(date: search_date) unless search_tel #日付
        
                Reservation.where(tel: search_tel) unless search_date #電話番号
                
                Reservation.where(date: search_date, tel: search_tel) #フル入力
    end

end
    