class ReservationsController < ApplicationController
    
    def index
        
    end
    
    
    def reserved_index
        
    end
    
    
    def choose_menus
        @reservation = Reservation.new
        @menus = Menu.where(category: 1)
        @menus2 = Menu.where(category: 2)
        @menus3 = Menu.where(category: 3)
        @menus4 = Menu.where(category: 4)
        @menus5 = Menu.where(category: 5)
        @menus6 = Menu.where(category: 6)
        
        @haircut = 'カット'
        @colour = 'カラー'
        @curl = 'パーマ'
        @treatment = 'トリートメント'
        @setting_your_hair = 'ヘアセット'
        @other = 'その他'
        
    end
    
    def choosen_menus
        menus = params[:menus]
        #logger.debug("-------menus=#{menus}")
        
        if menus
            selected_Menus = menus.map{ |menu| Menu.find_by(id: menu)}
        end
            
            #logger.debug("-------@selectedMenus=#{@selected_Menus.inspect}")
        
        if selected_Menus
            redirect_to controller: 'reservations', action: 'choose_staff', selected_Menus: selected_Menus
        end
    end

    
    
    def choose_staff
        @selected_Menus = params[:selected_Menus]
        logger.debug("-------@selected_Menus=#{@selected_Menus}")
        @staffs = Staff.all.order(status: :ASC)
        @name = '名前'
        @age = '年齢'
        @gender = '性別'
        @status = '階級'
        
       
        menus=[]
        
        @selected_Menus.each do |selected_Menu|
            if Menu.find_by(id: selected_Menu)
                menus.push(Menu.find_by(id: selected_Menu))
            end
        end
    
        #logger.debug("-------menus=#{menus}")
    
        @menu_ids=[]
        names=[]
        prices=[]
        required_times=[]
    
        menus.each do |menu|
            @menu_ids.push(menu.id)
            names.push(menu.name)
            prices.push(menu.price)
            required_times.push(menu.required_time)
        end
        
        
        #logger.debug("-------@menu_ids=#{@menu_ids}")
        @menu_names = names.join(',')
        prices_integer = prices.map{|x| x.to_i}
        @menu_prices = prices_integer.sum
        required_times_integer = required_times.map{|x| x.to_i}
        @menu_required_times = required_times_integer.sum
        #logger.debug("----- @selected_Menus=#{ @selected_Menus}")
        
    end
    
    
    def choosen_staff
        staffId = params[:staff_id]
        menuIds = params[:menu_ids]
        menuNames = params[:menu_names]
        menuPrices = params[:menu_prices]
        menuRequiredTimes = params[:menu_required_times]
        
        logger.debug("-------staffId=#{staffId}")
        logger.debug("-------menuIds=#{menuIds}")
        logger.debug("-------menuNames=#{menuNames}")
        logger.debug("-------menuPrices=#{menuPrices}")
        logger.debug("-------menuRequiredTimes=#{menuRequiredTimes}")
        
        if staffId && menuIds
             redirect_to controller: 'reservations', action: 'choose_date', selected_Staff: staffId, menu_ids: menuIds, menu_names: menuNames,
                                                                            menu_prices: menuPrices, menu_required_times: menuRequiredTimes
        else
            flash.now[:alert] = 'スタイリストを選択してください。'
            render :choose_staff
        end
        
    end
    
    
    def choose_date
        #paramsで受け取ると文字列になる。
        staffId = params[:selected_Staff]
        menuIds = params[:menu_ids]
        @menuNames = params[:menu_names]
        @menuPrices = params[:menu_prices]
        @menuRequiredTimes = params[:menu_required_times]
        
        #文字列で受け取ったので数値に直す。
        @price = @menuPrices.to_i
        
        
        @staff = Staff.find(staffId)
            
        
        logger.debug("-------staffId=#{staffId}")
        logger.debug("-------menuIds=#{menuIds}")
        logger.debug("-------menuNames=#{@menuNames}")
        logger.debug("-------menuPrices=#{@menuPrices}")
        logger.debug("-------menuRequiredTimes=#{@menuRequiredTimes}")

    
    end
    
    def choosen_date
        
    end
    
    
    def custamer_detail
        
    end
    
    def confirmation
        
    end
    
    def create
    
    end
    
    
    def destroy
        
    end
        
    
end
