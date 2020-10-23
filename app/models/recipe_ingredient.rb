# == Schema Information
#
# Table name: recipe_ingredients
#
#  quantity      :decimal(, )      not null
#  ingredient_id :integer          not null
#  recipe_id     :integer          not null
#
# Indexes
#
#  index_recipe_ingredients_on_recipe_id_and_ingredient_id  (recipe_id,ingredient_id) UNIQUE
#
class RecipeIngredient < ApplicationRecord
    belongs_to :ingredient
    belongs_to :recipe

    validates :ingredient, presence: true, uniqueness: { scope: :recipe }
    validates :recipe, presence: true, uniqueness: { scope: :ingredient }
    validates :quantity, presence: true, numericality: { greater_than: 0 }
end
