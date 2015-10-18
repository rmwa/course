class PagesController < ApplicationController
  
  def home
    if logged_in?
     redirect_to recipes_path
    end
  end

end
