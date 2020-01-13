class StaffsController < ApplicationController
 before_action :basic_auth, if: :production?
 before_action :staff_id_check, only: [:edit, :update, :destroy]
    
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
        staff = Staff.find_by(id: params[:id])
        staff.destroy
        redirect_to staffs_path
            

    end

    private
        def staff_params
             params.require(:staff).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :number, :age, :gender,
                                           :experience, :status, :self_introduction, :image)
        end


        def staff_id_check
            staff = Staff.find_by(id: params[:id])
            
            if staff.nil?
                flash[:alert] = 'メニューがありません。'
                redirect_to root_path
                
            end
        end
end
