class Reservation < ApplicationRecord
    
    belongs_to :staff
    belongs_to :menu
   
    
    validates :staff_id, :menu_id, :frames, :last_name, :first_name, :tel, :email, :gender,
              :request, :check, presence: true
              
    validates :date, presence: true,  uniqueness: true     
    validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :tel, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true, format: { with: /\A\S+@\S+\.\S+\z/, message: '適切なアドレスを入れてください。'}
    
    
    
    
    
    
    
    
    
    
end
    