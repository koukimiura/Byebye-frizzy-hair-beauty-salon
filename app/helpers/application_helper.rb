module ApplicationHelper
    
    
    #共通のhelperメソッド
    def number_to_currency(menu)
        "￥#{menu.price.to_s(:delimited, delimiter: ',')}"
    end
    

end
