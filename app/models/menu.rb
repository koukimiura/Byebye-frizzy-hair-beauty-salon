class Menu < ApplicationRecord
    
    require 'active_support/core_ext/numeric/conversions'
    
    with_options presence: true do
        validates :name
        validates :category
        validates :price
        validates :required_time
    end
    

    validates :name, uniqueness: true
    
    validates :price, format: { with: /\A[0-9]+\z/, message: "半角数値のみが使用できます" }
    
    validates :required_time, format: { with: /\A[0-9]+\z/, message: "半角数値のみが使用できます" }


    #scope :group, ->(argument) { where(category: argument) }

end
