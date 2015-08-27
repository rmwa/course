class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.all
  end

  def new
  end

  def edit
  end

  def show
    @recipe = Recipe.find(params[:id]) 
  end
end
