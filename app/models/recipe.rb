# == Schema Information
#
# Table name: recipes
#
#  id             :integer          not null, primary key
#  directions     :text
#  estimated_time :integer
#  name           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :integer          not null
#
# Indexes
#
#  index_recipes_on_category_id  (category_id)
#  index_recipes_on_name         (name) UNIQUE
#
# Foreign Keys
#
#  category_id  (category_id => categories.id)
#
class Recipe < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :estimated_time, numericality: { greater_than: 0, only_integer: true }
    validates :category, presence: true
    validates :recipe_ingredients, length: { minimum: 1 }
    
    belongs_to :category
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    has_many :ratings

    accepts_nested_attributes_for :recipe_ingredients, allow_destroy: true
end
