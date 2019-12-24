class ReservationsController < ApplicationController
    
   # before_action:reservation_params_for_json, only: [:create]
    
    
    def search
        @staffs = Staff.all.order(status: :asc)
        
        date = Date.today
        @dates = (date..date + 2.month)
        #logger.debug("----------dates=#{dates}")
        
        @reservations = Reservation.search(params[:search_last_kana], params[:search_first_kana], params[:search_staff], params[:search_date])
    #@reservation = Reservation.find_by(id: 2)
    #@frames = JSON.parse(@reservation.frames)
    #logger.debug("------------frames=#{frames.class}")
    
    
    end
    
    
    def index
        
        end_this_month = Date.today.end_of_month
        
        d = (Date.today..end_this_month)
        @this_month_reservations = Reservation.where(date: d)
        @after_this_month_reservations = Reservation.all.order(date: :desc)
        
        mixed_reservations = @this_month_reservations | @after_this_month_reservations
        @reservations = mixed_reservations.uniq
        
#--------------検索-----------------        
        
        @staffs = Staff.all.order(status: :asc)
        
        date = Date.today
        @dates = (date..date + 2.month)
        #logger.debug("----------dates=#{dates}")
        
        @searchedReservations = Reservation.search(params[:search_last_kana], params[:search_first_kana], params[:search_staff], params[:search_date])

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
        menuIds = menuIds_params
        #logger.debug("-------menus=#{menus}")

        #if menus
         #   selected_Menus = menus.map{ |menu| Menu.find_by(id: menu)}
        #end
        
        logger.debug("----------menuIds_params=#{menuIds_params}")
        

        if menuIds.present?
            
            
            
        #javascriptで　returnをして飛べないようにしてます。
            
        redirect_to controller: 'reservations', action: 'choose_staff', menus: menuIds_params
            
            
            
        else
            
            render :choose_menus
        end
    end

    
    
    def choose_staff
        
        selectedMenus = menuIds_params
        
        #choose_dateからきたvalue
        #selectedMenuIdsFromChooseDate = params[:selectedMenuIds]
        
        #Arrayに作り直し
        #selected_Menus2 = [selectedMenuIdsFromChooseDate.to_i]
        
        @staffs = Staff.all.order(status: :ASC)
        
        @name = '名前'
        @age = '年齢'
        @gender = '性別'
        @status = '階級'
        
        #view用
        @menuIds =  menuIds_params
        
       #selected_Menus = selectedMenus #||= selected_Menus2
      
      

      
      
        #-------------------------------------------
        logger.debug("------selectedMenus=#{selectedMenus}")
        
        menus = selectedMenus.map{|menuId|totalMenus(menuId)}
        
        names = menus.map{|menu| name(menu)}
        #文字列をまとめる
        @menuNames = names.join('+')
        
        prices = menus.map{|menu| price(menu)}
        required_times = menus.map{|menu| required_time(menu)}
        
        #各文字列をintegerにして合計金額と時間を出す。
        prices_integer = prices.map{|x| integer(x)}
        required_times_integer = required_times.map{|y| integer(y)}
        
        @menuPrices = prices_integer.sum
    
        @menuRequiredTimes = required_times_integer.sum
    
    end
    
    
    #def choosen_staff

    
        #logger.debug("-------staffId=#{staffId}")
        #logger.debug("-------menuIds_params=#{menuIds_params}")
        
        #if staffId_params && menuIds_params
             #redirect_to controller: 'reservations', action: 'choose_date', selected_Staff: staffId, menu_ids: menuIds, menu_names: menuNames,
                                                                            #menu_prices: menuPrices, menu_required_times: menuRequiredTimes
                                                                            
             #redirect_to controller: 'reservations', action: 'choose_date', selectedStaff: staffId_params, menus: menuIds_params                                                                
        #else
            
            #flash.now[:alert] = 'スタイリストを選択してください。'
            #render :choose_staff
        #end
        
    #end
    
    
    def choose_date
        #paramsで受け取ると文字列になる。
        
        @menuIds = menuIds_params
        staffId = staffId_params
        
        #logger.debug("-------@menuIds=#{@menuIds}")
        logger.debug("-------staffId=#{staffId}")

        
        #先週と来週の日数
        receivedNext = params[:next_week]
        receivedPrev = params[:previous_week]

        
        @staff = Staff.find(staffId)
        
        #menuIds = menuIds_params
        #menuIds = params[:selectedMenus]
        #@menuNames = params[:menu_names]
        #menuPrices = params[:menu_prices]
        #@menuRequiredTimes = params[:menu_required_times]
        
        
        
        #-------------メニュー-----------------------
        
        
        menus = @menuIds.map{|menuId|totalMenus(menuId)}
        names = menus.map{|menu| name(menu)}
        #文字列をまとめる
        @menuNames = names.join(',')
        
        #各文字列をintegerにして合計金額と時間を出す
        prices = menus.map{|menu| price(menu)}
        required_times = menus.map{|menu| required_time(menu)}
        
        #各文字列をintegerにして合計金額と時間を出す。
        prices_integer = prices.map{|x| integer(x)}
        required_times_integer = required_times.map{|y| integer(y)}
        
        #合計の出し方
        @menuPrices = prices_integer.sum
        @menuRequiredTimes = required_times_integer.sum
        
        
    
        #@dの条件文
        
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
        
        #logger.debug("-------menuIds=#{@menuIds}")
        #logger.debug("-------menuNames=#{@menuNames}")
        #logger.debug("-------menuPrices=#{@menuPrices}")
        #logger.debug("-------menuRequiredTimes=#{@menuRequiredTimes}")
    end
    
    
    
    def custamer_detail
       # 日付
        @date = params[:date]
        #必要時間
        menuRequiredTimes = params[:menu_required_times]
        
        @staffId = staffId_params
        @menuIds = menuIds_params
        
        
        logger.debug("-------------@menuIds=#{@menuIds}")
        
        #menuRequiredTimesをFloat化して30でわる。
        number = menuRequiredTimes.to_f/30
        toInteger = number.to_i
         
        logger.debug("-------toInteger=#{toInteger}")
         
         
         
                #30分以下　
         if toInteger < 1
             
             updateNumber = 0
         
        #Integerのアルゴリズムs
        elsif 0 == number % toInteger        
            
            updateNumber = toInteger
            
        else
            
            #少数アルゴリズム
            number_float = number + 1                   #else以下に入れるnumberはFloatなので + 1しupdateするカラム数にあわせる。
            updateNumber =  number_float.to_i
            
        end
        
        #updateNumbeはupdateするDBのカラム数。
        
        logger.debug("---------- updateNumber=#{updateNumber}")
                                                                   
       selectedSchedule =  Schedule.find_by(staff_id: @staffId, date: params[:date], frame: params[:frame])      #選択された日程からidを割り出す。
       
       

       #updateしたカラムにおけるFrameを取得
        @total_frames=[]     
       
       
                    #iに0~6のインデックス番号が入ってます。
                    #Schedule.status_frameを仮予約状態にする。
                    
                    
       updateNumber.times do |i|      
           
           logger.debug("--------i =#{i}")
           scheduleId = selectedSchedule.id + i
           
           schedule = Schedule.find_by(id: scheduleId)
           logger.debug("------schedule.id=#{schedule.id}")
           #schedule.update(frame_status: "keep")
           
           @total_frames.push(schedule.frame)
           
       end
       
       
      @reservation = Reservation.new
       
        
    end
    
    
    
    
    def custamer_info
        staffId = staffId_params
        menuIds = menuIds_params
        times = frames_params
        
        logger.debug("-------menuIds=#{menuIds}")
        logger.debug("-------times=#{times}")
        logger.debug("-----------staffId=#{staffId}")
        @reservation = Reservation.new(reservation_params)
    
        #saveメソッドを使わないのでバリデーションによるエラーメッセージ を出せない。 
        if @reservation.last_name.present? && @reservation.first_name.present?  && @reservation.last_name_kana.present? && 
           @reservation.first_name_kana.present? && @reservation.tel.present? && @reservation.email.present? &&
           staffId.present? && menuIds.present?  && times.present?
        
           
           
           redirect_to confirmation_reservations_path(menus: menuIds_params, selectedStaff: staffId_params,
                                        frame: frames_params, reservation: reservation_params)
                                        

        else
            
            flash[:alert] ='記入が漏れがあります。'
            redirect_to :back
         
            
        end
    end
    
    
    
    def confirmation #newアクションのかわり
        
        staffId = staffId_params
        @menuIds = menuIds_params
        @frames = frames_params
        @reservation = Reservation.new(reservation_params)
        
        #@hash_frames = {h_frames: {key_frames: @frames}}
        #@hash_frames = JSON.parse(hash_frames.to_json)
        
        #hash化した
        @hash_frames = {key_frames: @frames}
        @hash_menuIds = {key_menuIds: @menuIds}
        
        
        
        logger.debug("-------@menuIds=#{@menuIds}")
        logger.debug("-------@frames=#{@frames}")
        
        #ストロングパラメータのclassは
        logger.debug("-----------reservation_params.class=#{reservation_params.class}")
       
       
        @date = Date.parse(@reservation.date)
        
        @check = '初来店' if @reservation.check == 'true'
        @check = '再来店' if @reservation.check == 'false'
        @staff = Staff.find(staffId)
       
       
        #------------------------------------
        
        
        menus = @menuIds.map{|menuId|totalMenus(menuId)}
        names = menus.map{|menu| name(menu)}
        #文字列をまとめる
        @menuNames = names.join(',')
        
        prices = menus.map{|menu| price(menu)}
        required_times = menus.map{|menu| required_time(menu)}
        
        #各文字列をintegerにして合計金額と時間を出す。
        prices_integer = prices.map{|x| integer(x)}
        required_times_integer = required_times.map{|y| integer(y)}
        
        @menuPrices = prices_integer.sum
    
        @menuRequiredTimes = required_times_integer.sum
        
        #render :json => @reservation
    
    end
    
    
    

    def create
        #json = params[:frames]
        #@reservation = Reservation.new(reservation_params)
        
        #json_frames = JSON.parse(params[:frames].to_json)
        #json_frames = JSON.parse(reservation_params[:frames].to_json)
    
        #reservation_paramsをjson化しないとhashとして扱えない。 各カラムだけやるとStringになってしまう。
        #hash_reservation_params = JSON.parse(reservation_params.to_json, {symbolize_names: true})
        #hash_frames = hash_reservation_params.as_json(only: [:frames])
        #string_frames = hash_reservation_params[:frames]
        #hash_frames = to_hash(string_frames)
        
        
        
        
        
        #JSON文字列で受け取りhashとして扱いvalueを必要な形に崩していく
        
        #framesのJSON文字列{key_frames: @frames}をparseしてhashとして扱えるようにする。
        hash_frames = JSON.parse(reservation_params[:frames], {symbolize_names: true})
        #hash　:key_framesのvalueを取得
        array_frames = hash_frames[:key_frames]

        #framesのJSON文字列{key_menuIds: @menuIds}をparseしてhashとして扱えるようにする。
        hash_menuIds = JSON.parse(reservation_params[:menu_ids], {symbolize_names: true})
        #配列を取得
        array_menuIds = hash_menuIds[:key_menuIds]

        
        
        logger.debug("--------reservation_params=#{reservation_params}")
        #logger.debug("--------hash_reservation_params=#{hash_reservation_params.class}")
        #logger.debug("--------hash_reservation_params=#{hash_reservation_params}")

        logger.debug("--------hash_frames.class=#{hash_frames.class}")
        logger.debug("--------hash_frames=#{hash_frames}")
        logger.debug("--------array_frames=#{array_frames}")

        logger.debug("--------array_menuIds=#{array_menuIds} ")

           # product_params['type'].each do |t|
           # product.name = product_params['name']
            #product.about = product_params['about']
           # product.type = t
            #product.save 
            
        reservation = Reservation.new(staff_id: reservation_params[:staff_id],
                                  date: reservation_params[:date],
                                  last_name: reservation_params[:last_name],
                                  first_name: reservation_params[:first_name],
                                  last_name_kana: reservation_params[:last_name_kana],
                                  first_name_kana: reservation_params[:first_name_kana],
                                  tel: reservation_params[:tel],
                                  email: reservation_params[:email],
                                  check: reservation_params[:check],
                                  gender: reservation_params[:gender],
                                  request: reservation_params[:request],
                                  frames: array_frames, 
                                  menu_ids: array_menuIds)

        if reservation.save
            flash[:notice] ='予約が確定しました。'
            redirect_to root_path
            
        else
            flash[:alert] ='記入が漏れがあります。'
            redirect_to :back
            #redirect_back(fallback_location: fallback_location)
        end
    end
    
    
    def destroy
        reservation = Reservation.find(params[:id])
        reservation.destroy
        flash[:alert] = '予約を削除しました。'
        redirect_to :back
        
    end
    
    
    
    private
    
        def menuIds_params
            params[:menus]
        end
        
        def staffId_params
            params[:selectedStaff]
        end
        
        def frames_params
             params[:frame]
        end
    
        
        #ストロングパラメータは制限かけてるですーー
        def reservation_params
            #json_request = ActionController::Parameters.new(JSON.parse(request.body.read))
            #json_request.permit(:staff_id, :last_name, :first_name, :last_name_kana, :first_name_kana, :tel, 
                                #:email, :gender, :request, :check, :date, :frames)
            params.require(:reservation).permit(:staff_id, :last_name, :first_name, :last_name_kana,
                                                :first_name_kana, :tel, :email, :gender, :request, :check, :date, :frames, :menu_ids)
        end

#------------------------------------menu----------------------------------------


        def totalMenus(menuId)
            menu = Menu.find_by(id: menuId)
            return menu
        end
        
        def name(menu)
            return menu.name
        end
        
        def required_time(menu)
            return menu.required_time
        end
        
        def price(menu)
            return menu.price
        end
        
        def integer(x)
            return x.to_i
        end
        
        def integer(y)
            return y.to_i
        end

end
