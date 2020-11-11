class RecipesController < ApplicationController
  before_action :require_logged_in, except: %i[index show]
  before_action :set_category
  before_action :set_recipe, only: %i[show edit update destroy]

  def index
    @recipes = Recipe.in_category(@category)
    order = params[:order]
    if order.to_s == 'alpha'
      @recipes = @recipes.order(:name)
    elsif order.to_s == 'created'
      @recipes = @recipes.order(created_at: :desc)
    elsif order.to_s == 'estimated_time'
      @recipes = @recipes.order(:estimated_time)
    elsif order.to_s == 'rating'
      @recipes = @recipes.to_a.sort(&:average_rating).reverse
    end
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
    @ratings = @recipe.ratings.all
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

