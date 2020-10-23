class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category), notice: "Category saved successfully"
    else
      render :new, alert: "Category failed to save"
    end
  end

  def show
    redirect_to category_recipes_path(@category)
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category), notice: "Category saved successfully"
    else
      render :new, alert: "Category failed to save"
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: "Category successfully deleted"
    else
      redirect_to category_path(@category), alert: "Category failed to delete"
    end
  end

private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
