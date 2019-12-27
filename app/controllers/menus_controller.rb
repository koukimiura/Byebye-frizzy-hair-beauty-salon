class MenusController < ApplicationController
  before_action :basic, if: :production?
  
  
  def index
    #@menus = Menu.all.order(category: :asc)
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
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
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
     @menu = Menu.find(params[:id])
     @menu.destroy
     redirect_to menus_path
  end
  
  privates
  
    def menu_params
      
      params.require(:menu).permit(:name, :category, :price, :required_time, :detail)
      
    end
  
  
end
