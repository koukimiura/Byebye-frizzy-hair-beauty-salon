class HomeController < ApplicationController
  
  #before_action :basic_auth, only: [:basic] #, if: :production?
  #before_action :require_login, only: [:new, :create]
  before_action :basic_auth, only: [:basic]
  
  def top
    
  end
  
  def basic
    
  end
end
