class Staff < ApplicationRecord
    
    
    mount_uploader :image, ImageUploader
    
    validates :last_name, presence: true
    validates :first_name, presence: true
    validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :first_name_kana, presence: true,format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
    validates :number, presence: true
    validates :number, uniqueness: true
    validates :age, presence: true
    validates :gender, presence: true
    validates :experience, presence: true
    validates :status, presence: true
    validates :self_introduction, presence: true
    validates :image, presence: true
    
    
    has_many :schedules, dependent: :destroy
    has_many :reservations
end
