class StaffsController < ApplicationController
    before_action :basic, if: :production?
    
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
        @staff_number = "推奨ナンバー00#{staffIds.last + 1}"
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
    end
    

    def update
        @staff = Staff.update(staff_params)
        flash[:notice] = '社員情報を編集しました。'
        redirect_to staffs_path
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
        logger.debug("-----params=#{@staff}")
        if @staff 
            #session[:staff_id] = @staff.id
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
