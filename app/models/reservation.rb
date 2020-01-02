class Reservation < ApplicationRecord
    
    require "json"
    belongs_to :staff
    
    #require trueがつく可能性が高い
    #belongs_to :menu     配列で入れてる
    
    #validates :staff_id, :frame, :frame_status, presence: true
    

    validates :staff_id, :menu_ids, :frames, :date, :gender, :last_name, :first_name, presence: true 
    
    validates :last_name_kana, :first_name_kana, presence: true,
                                                    format: { 
                                                             with: /\A[\p{katakana}　ー－&&[^ -~｡-ﾟ]]+\z/,
                                                             message: '全角カタカナのみで入力して下さい。'
                                                            }
    
    validates :tel, presence: true, 
                    format: {
                            with: /\A\d{10,11}\z/, 
                            message: '電話番号はハイフンなしです。'
                            }
    
    
    validates :email, presence: true,
                        format: { 
                                with: /\A\S+@\S+\.\S+\z/,
                                message: '適切なアドレスを入れてください。'
                                }
    
    
    









    




    
    #予約検索
    
    #クラスメソッド、　Reservation.searchってこと
    def self.search(search_tel, search_date, dates)
            
        return  Reservation.where(date: dates) unless search_tel || search_date #今日以降のデータ       
        
                Reservation.where(date: search_date) unless search_tel #日付
        
                Reservation.where(tel: search_tel) unless search_date #電話番号
                
                Reservation.where(date: search_date, tel: search_tel) #フル入力
    end
    
    
   

end
    