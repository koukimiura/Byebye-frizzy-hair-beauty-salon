module ApplicationHelper
    
    
    #共通のhelperメソッド
    def number_to_currency(menu)
        priceM = menu.price
        "￥#{priceM.to_s(:delimited)}"
    end
    

end
