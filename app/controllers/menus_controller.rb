class MenusController < ApplicationController
  before_action :basic_auth, if: :production?
  before_action :menu_id_check, only: [:edit, :update, :destroy]
  
  def index
  
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


  def new
    @menu = Menu.new
  end


  def create
    
    @menu = Menu.new(menu_params)
    if @menu.save
      flash[:notice] = '新メニューを作成しました。'
      redirect_to menus_path
    else
      flash.now[:alert] = '新メニューを作成できません。'
      render :new
    end
  end



  def edit
    @menu = searchId
  end



  def update
    @menu = searchId
    @menu.assign_attributes(menu_params)
    
    if @menu.save
      flash[:notice] = 'メニューを編集しました。'
      redirect_to menus_path
    else
      flash.now[:alert] = '新メニューを編集できません。'
      render :edit
    end
    
  end



  def destroy
     menu = searchId
    
      menu.destroy
      redirect_to menus_path
  end
  
  
  
  private
  
    def menu_params
      
      params.require(:menu).permit(:name, :category, :price, :required_time, :detail)
      
    end
  
    def menu_id_check
        menu = searchId
        
        if menu.nil?
            flash[:alert] = 'メニューが見つかりません。'
            redirect_to root_path
        end
      
    end
    
    def searchId
      
      Menu.find_by(id: params[:id])
      
    end

end
