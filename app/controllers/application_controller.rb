class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :logged_in?, :current_user
  
  def logged_in?
    !!current_user
  end
  
  def current_user
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end
  
  def require_login
    if !logged_in?
      flash[:warning] = "You must be logged in to do that."
      redirect_to :back  
    end
  end  

end
