class ToppagesController < ApplicationController
  def index
    
    if logged_in?
      redirect_to tasks_path
    end
    
  end
end
