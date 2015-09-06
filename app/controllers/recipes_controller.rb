class RecipesController < ApplicationController
  
  def index
    # @recipes = Recipe.all.sort_by{|likes| likes.thumps_up_total}.reverse
    @recipes = Recipe.paginate(page: params[:page], per_page: 4)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.find(4)
    if @recipe.save
      flash[:success] = "Your recipe was created successfully"
      redirect_to recipes_path
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
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
    @recipe = Recipe.find(params[:id])
    l = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe)
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
  
end
