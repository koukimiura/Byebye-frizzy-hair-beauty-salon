module ApplicationHelper
    
    
    #共通のhelperメソッド
    def number_to_currency(menu)
        logger.debug("---------------menu.price=#{menu.price.class}")
        logger.debug("---------------menu.price.to_s=#{menu.price.to_s}")
        "￥#{menu.price.to_s(:delimited)}"
    end
    

end
