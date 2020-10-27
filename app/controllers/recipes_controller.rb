class RecipesController < ApplicationController
  before_action :require_logged_in, except: %i[index show]
  before_action :set_category
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = @category.recipes
  end

  def new
    @recipe = @category.recipes.build
  end

  def create
    @recipe = @category.recipes.build(recipe_params)
    if @recipe.save
      redirect_to category_recipe_path(@category, @recipe), notice: "Recipe saved successfully"
    else
      render :new, alert: "Recipe failed to save"
    end
  end

  def show
    @ratings = @recipe.ratings
    @rating = @ratings.build
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to category_recipe_path(@category, @recipe), notice: "Recipe saved successfully"
    else
      render :new, alert: "Recipe failed to save"
    end
  end

  def destroy
    if @recipe.destroy
      redirect_to category_recipes_path(@category), notice: "Recipe successfully deleted"
    else
      redirect_to category_recipe_path(@category, @recipe), alert: "Recipe failed to delete"
    end
  end

private
  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_recipe
    @recipe = @category.recipes.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :estimated_time, :directions, recipe_ingredients_attributes: %i[ingredient_id quantity _destroy])
  end
end

