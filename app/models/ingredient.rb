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
    
    has_many :recipe_ingredients
    has_many :recipes, through: :recipe_ingredients

    def for_dropdown
        [ "#{name} (#{units})", id ]
    end

    def self.for_dropdown
        all.collect(&:for_dropdown)
    end

end
