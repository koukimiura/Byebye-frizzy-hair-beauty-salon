Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  
  #root 'home#basic'
  #get 'home/top' => 'home#top'
  root 'home#top'
  get 'home/basic' => 'home#basic'
  
  resources :staffs do
    collection do
      get 'login_form'
      post 'login'
    end
  end
  
  resources :menus, only: [:index, :new, :create, :edit, :update, :destroy]
  
  
  resources :schedules, only: [:create, :index] 
  #get 'schedules/:staff_id/new' => 'schedules#new'
  get 'schedules/new' => 'schedules#new'
  get 'schedules/date_workers' => 'schedules#date_workers'
  
  resources :reservations, only: [:destroy, :create, :index] do
    collection do 
      #get 'reserved_index'
      get 'search'
      get 'choose_menus'
      post 'choosen_menus'
      get 'choose_staff'
      post 'choosen_staff'
      get 'choose_date'
      #post 'choosen_date'
      get 'custamer_detail'
      post 'custamer_info'
      get 'confirmation'
    end
    
  end
  
  
  
end
