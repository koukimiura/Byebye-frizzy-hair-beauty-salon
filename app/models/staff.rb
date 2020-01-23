class Staff < ApplicationRecord
    
    
    has_many :schedules, dependent: :destroy
    has_many :reservations
    mount_uploader :image, ImageUploader
    
    
    with_options presence: true do
        validates :last_name
        validates :first_name
        validates :age
        validates :experience
        validates :gender 
        validates :status
        validates :self_introduction
        validates :image, presence: true
    end
    
    
    validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :first_name_kana, presence: true,format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :number, presence: true, uniqueness: true

    def last_nameANDfirst_name
        
        return '(' + self.number.to_s + ')' + self.last_name + self.first_name
        
    end
    
    
    
    
end
