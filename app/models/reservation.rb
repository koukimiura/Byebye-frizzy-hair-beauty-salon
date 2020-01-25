class Reservation < ApplicationRecord
    
    require "json"
    belongs_to :staff
    
    #require trueがつく可能性が高い
    #belongs_to :menu     配列で入れてる
    

    with_options presence: true do
        validates :staff_id
        validates :menu_ids
        validates :frames
        validates :date
        validates :gender 
        validates :last_name
        validates :first_name
    end
    
    
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
            
            #今日以降のデータ    
            if search_tel.present? && search_date.present?
            
                result = Reservation.where(date: search_date, tel: search_tel).order(date: :asc)      
            
            #日付
            elsif search_date.present?
            
                result = Reservation.where(date: search_date).order(date: :asc)  
            
            #電話番号
            elsif search_tel.present?
            
                result = Reservation.where(tel: search_tel).order(date: :asc)  
            
            #フル入力    
            else
                
                result = Reservation.where(date: dates).order(date: :asc)
                
            end
            
        return result
    end
    
    
   

end
    