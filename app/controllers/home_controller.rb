class HomeController < ApplicationController
  before_action :basic, if: :production?, only: [:basic]
  
  def top
    
  end
  
  def basic
    
  end
end
