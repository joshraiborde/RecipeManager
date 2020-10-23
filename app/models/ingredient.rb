# == Schema Information
#
# Table name: ingredients
#
#  id    :integer          not null, primary key
#  name  :string           not null
#  units :string           not null
#
# Indexes
#
#  index_ingredients_on_name  (name) UNIQUE
#
class Ingredient < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :units, presence: true
    
    has_many :recipes_ingredients
    has_many :recipes, through: :recipe_ingredients
end
