class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    chef = Chef.find_by(email: params[:session][:email].downcase)
    if chef && chef.authenticate(params[:session][:password])
      session[:chef_id] = chef.id
      flash[:success] = "You are logged in."
      redirect_to recipes_path
    else
      flash.now[:danger] = "Email or password are not correct."
      render 'new'
    end
  end

  def destroy
    session[:chef_id] = nil
    flash[:success] = "You are logged out."
    redirect_to root_path
  end
  
end
