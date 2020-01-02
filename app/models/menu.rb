class Menu < ApplicationRecord
    
    require 'active_support/core_ext/numeric/conversions'
    
    #has_many :reservations
    
    validates :name, :category, :price, :required_time, presence: true
    
    validates :name, uniqueness: true
    validates :price, format: { with: /\A[0-9]+\z/, message: "半角数値のみが使用できます" }
    
    validates :required_time, format: { with: /\A[0-9]+\z/, message: "半角数値のみが使用できます" }
    

    
end
