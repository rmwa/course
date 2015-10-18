class ChefsController < ApplicationController
  
  before_action :require_login, only: [:edit, :update]
  
  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 4)
  end

  def new
    @chef = Chef.new
  end
  
  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Your Account has been created successfully"
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
    # require_login
    @chef = Chef.find(params[:id])
    require_same_user
  end

  def update
    # require_login
    @chef = Chef.find(params[:id])
    require_same_user
    if @chef = Chef.update(chef_params)
      flash[:success] = "Your Profile was updated successfully"
      session[:chef_id] = @chef.id
      redirect_to chef_path(@chef)
    else
      render :edit
    end
  end

  def show
    @chef = Chef.find(params[:id])
    @recipes = @chef.recipes.paginate(page: params[:page], per_page: 3)
  end

  def destroy
  end

  
  private
  
    def chef_params
      params.require(:chef).permit(:chefname, :email, :password)
    end
  
    def require_same_user
      if @chef != current_user
        flash[:warning] = "You cannot edit this profile."
        redirect_to root_path
      end
    end
    
end
