class IngredientsController < ApplicationController
  before_action :require_logged_in, except: %i[index show]
  before_action :set_ingredient, only: %i[show edit update destroy]

  def index
    @ingredients = Ingredient.all
  end

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      redirect_to ingredient_path(@ingredient), notice: "Ingredient saved successfully"
    else
      render :new, alert: "Ingredient failed to save"
    end
  end

  def edit
  end

  def update
    if @ingredient.update(ingredient_params)
      redirect_to ingredient_path(@ingredient), notice: "Ingredient saved successfully"
    else
      render :new, alert: "Ingredient failed to save"
    end
  end

  def destroy
    if @ingredient.destroy
      redirect_to ingredients_path, notice: "Ingredient successfully deleted"
    else
      redirect_to ingredient_path(@ingredient), alert: "Ingredient failed to delete"
    end
  end

private
  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :units)
  end
end
