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
    
        @menuIds=[]
        names=[]
        prices=[]
        required_times=[]
    
    
        menus.each do |menu|
            @menuIds.push(menu.id)
            names.push(menu.name)
            prices.push(menu.price)
            required_times.push(menu.required_time)
        end
        
        
        #logger.debug("-------@menu_ids=#{@menu_ids}")
        
        #文字列をまとめる
        @menuNames = names.join(',')
        
        #各文字列をintegerにして合計金額と時間を出す。
        prices_integer = prices.map{|x| x.to_i}
        @menuPrices = prices_integer.sum
        
        required_times_integer = required_times.map{|x| x.to_i}
        @menuRequiredTimes = required_times_integer.sum
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
        @menuIds = params[:menu_ids]
        @menuNames = params[:menu_names]
        menuPrices = params[:menu_prices]
        @menuRequiredTimes = params[:menu_required_times]
        receivedNext = params[:next_week]
        receivedPrev = params[:previous_week]
        
        #文字列で受け取ったので数値に直す。
        @menuPrices = menuPrices.to_i
        @staff = Staff.find(staffId)
        
        
        if receivedNext
            @d = Date.parse(receivedNext)
            #logger.debug("------d=#{@d}")
            #date= Date.parse(receivedNext)
            
        elsif receivedPrev && Date.parse(receivedPrev) < Date.today  #elsifの順番
            @d = Date.today      #- 2.day
            #date=Date.today
        elsif receivedPrev
            @d = Date.parse(receivedPrev)
            #date=Date.parse(receivedPrev)
        else 
            @d = Date.today
            #date=Date.today
        end
        
         @next = @d + 1.week #aタグ用
         @prev = @d - 1.week #aタグ用
        #d = Date.today + 1.week
        
        #@calenders = reservation_calender(@d, @staff)
        
        
        
        
         
        logger.debug("-------staffId=#{staffId}")
        logger.debug("-------menuIds=#{@menuIds}")
        logger.debug("-------menuNames=#{@menuNames}")
        logger.debug("-------menuPrices=#{@menuPrices}")
        logger.debug("-------menuRequiredTimes=#{@menuRequiredTimes}")
        
        
        
       
    end
    
    
    def choosen_date
        
        
        
    end
    
    
    def custamer_detail
        params[:date]
        params[:frame]
        staffId = params[:selected_Staff]
        @menuIds = params[:menu_ids]
        @menuNames = params[:menu_names]
        @menuPrices = params[:menu_prices]
        @menuRequiredTimes = params[:menu_required_times]
        
        
        #保留
        
       # if @menuRequiredTimes.to_i < 30
        #schedule = Schedule.find_by(staff_id: staffId, date: params[:date], frame: params[:frame], frame_status: "available")
        
        #schedule.update(frame_status: "reserved")
        
       # elsif @menuRequiredTimes.to_i > 30 && @menuRequiredTimes.to_i <= 60
       # schedule = Schedule.find_by(staff_id: staffId, date: params[:date], frame: params[:frame], frame_status: "available")
        #secondId = schedule.id + 1
       # if Schedule.find_by(id: secondId, frame_status: "available")
            #schedule.update(frame_status: "reserved")
           # Schedule.find_by(id: secondId).update(frame_status: "reserved")
        #end
        
       # end
        
        
        
        @reservation = Reservation.new
        
        
    end
    
    
    #def confirmation
        
    #end
    
    def new  #confirmation
        
        
        redirect_to confirmation_reservations_path
        
        flash[:alert] ='記入が漏れがあります。'
        render :confirmation
        
    end
    
    
    def create
        
        @reservation = Reservation.new(reservation_params)
        if @reservation.save
            flash[:notice] ='予約が確定しました。'
            
        else
            flash[:alert] ='記入が漏れがあります。'
            
        end
    
    end
    
    
    def destroy
        reservation = Reservation.find(params[:id])
        reservation.destroy
        flash[:alert] = '予約を削除しました。'
        redirect_to :back
        
    end
    
    private
    
    def reservation_params
        
        params.require(:reservation).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :number, :age, :gender,
                                           :experience, :status, :self_introduction, :image)
        
    end
    
end
