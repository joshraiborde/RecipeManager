class RatingsController < ApplicationController
  before_action :require_logged_in
  before_action :set_recipe

  def create
    @rating = @ratings.build(rating_params)
    @rating.user = current_user
    if @rating.save
      redirect_to category_recipe_path(@category, @recipe), notice: "Rating saved successfully"
    else
      render :new, alert: "Rating failed to save"
    end
  end

  def destroy
    @rating = @ratings.where(user: current_user).find(params[:id])
    if @rating.destroy
      redirect_to category_recipe_path(@category, @recipe), notice: "Rating successfully deleted"
    else
      redirect_to category_recipe_path(@category, @recipe), alert: "Rating failed to delete"
    end
  end

private
  def rating_params
    params.require(:rating).permit(:rating)
  end

  def set_recipe
    @category = Category.find(params[:category_id])
    @recipe = @category.recipes.find(params[:recipe_id])
    @ratings = @recipe.ratings
  end
end
