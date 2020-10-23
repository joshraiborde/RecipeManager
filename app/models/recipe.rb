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
#  categories_id  :integer          not null
#
# Indexes
#
#  index_recipes_on_categories_id  (categories_id)
#  index_recipes_on_name           (name) UNIQUE
#
# Foreign Keys
#
#  categories_id  (categories_id => categories.id)
#
class Recipe < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :estimated_time, numericality: { greater_than: 0, only_integer: true, allow_nil: true }
    validates :category, presence: true
    
    belongs_to :category
    has_many :recipes_ingredients
    has_many :ingredients, through: :recipe_ingredients
    has_many :ratings
end
