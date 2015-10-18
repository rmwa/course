class RecipesController < ApplicationController
  
  before_action :require_login, except: [:index, :show]
  
  def index
    # @recipes = Recipe.all.sort_by{|likes| likes.thumps_up_total}.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
  end

  def new
    # require_login
    @recipe = Recipe.new
  end

  def create
    # require_login
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user
    if @recipe.save
      flash[:success] = "Your recipe was created successfully"
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
    # require_login
    @recipe = Recipe.find(params[:id])
    require_same_user
  end

  def update
    # require_login
    @recipe = Recipe.find(params[:id])
    require_same_user
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was updated successfully"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end  
  end

  def show
    @recipe = Recipe.find(params[:id]) 
  end
  
  def like
    # require_login
    @recipe = Recipe.find(params[:id])
    l = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if l.valid?
      flash[:success] = "Your vote was counted. Thanks."
      redirect_to :back
    else
      flash[:danger] = "You can onyl vote once."
      redirect_to :back
    end
  end
  
  
  private
    
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
  
    def require_same_user
      if @recipe.chef != current_user
        flash[:warning] = "You cannot edit this recipe."
        redirect_to root_path
      end
    end

end
