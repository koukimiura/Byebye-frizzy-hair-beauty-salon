Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  
  root 'home#top'
  get 'home/basic' => 'home#basic'
  
  resources :staffs do
    collection do
    end
  end
  
  resources :menus, only: [:index, :new, :create, :edit, :update, :destroy]
  
  
  resources :schedules, only: [:create, :index] 
  #get 'schedules/:staff_id/new' => 'schedules#new'
  get 'schedules/new' => 'schedules#new'
  get 'schedules/date_workers' => 'schedules#date_workers'
  
  resources :reservations, only: [:destroy, :create, :index] do
    collection do 
      get 'search'
      get 'choose_menus'
      post 'choosen_menus'
      get 'choose_staff'
      get 'choose_date'
      get 'custamer_detail'
      post 'deal'
      get 'confirm'
    end
    
  end
  
  
  
end
