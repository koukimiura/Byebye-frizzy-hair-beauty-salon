class StaffsController < ApplicationController
    before_action :basic_auth#, if: :production?
    
    def index
        @staffs = Staff.all.order(status: :asc)
        @name = '名前'
        @age = '年齢'
        @gender = '性別'
        @status = '階級'
    end
    
    
    def new
        @staff = Staff.new
        staffIds = Staff.pluck(:id)
        date = Date.today
        @staff_number = "推奨ナンバー#{date.year}#{staffIds.last + 1}"
        #logger.debug("----------@staff_number=#{@staff_number}")
    end
    
    
    def create
        @staff = Staff.new(staff_params)
            if @staff.save
                flash[:notice] = '社員登録完了しました。'
                redirect_to staffs_path
            else 
                flash.now[:alert] = '社員登録完了していません。'
                render :new
            end
    end
    
    
    def edit
        @staff = Staff.find(params[:id])
        @staff_image = @staff.image
    end
    

    def update
        
        #else以下が実行された場合 renderが発動するので@staffにしておけば、勝手staffでーたを飛ばしてくれます。
        @staff = Staff.find(params[:id])
        logger.debug("-------@staff=#{@staff.id}")
        logger.debug("-----------staff_params#{staff_params}")
        
        @staff.assign_attributes(staff_params)
        
        if @staff.save
            flash[:notice] = '社員情報を編集しました。'
            redirect_to staffs_path
            
        else
            flash.now[:alert] = '社員情報を編集できていません。'
            render :edit
            
        end
    end
    
    
    def destroy
        @staff = Staff.find(params[:id])
        @staff.destroy
        redirect_to staffs_path
    end
    
    
    def login_form
        
    end
    
    
    
    def login 
        @staff = Staff.find_by(last_name: params[:last_name], first_name: params[:first_name], number: params[:number])
        
        
        this_month_first_day = Date.today.beginning_of_month
        next_month = this_month_first_day.next_month
        rangeDates = (next_month..next_month.end_of_month)
        
        @schedules = Schedule.where(staff_id: @staff.id, date: rangeDates)  if @staff
        
        #logger.debug("-----@staff.id=#{@staff.id}")
        
        if @schedules.present?
            
            flash[:alert] = '今月のシフトは入力済みです。'
            redirect_to login_form_staffs_path
            
            
        elsif @staff  
        
           redirect_to "/schedules/#{@staff.id}/new"
        
        else
            @error_message = '名前または社員番号が違います。'
            render :login_form
        end
        
    end
    

    private
        def staff_params
             params.require(:staff).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :number, :age, :gender,
                                           :experience, :status, :self_introduction, :image)
        end

end
