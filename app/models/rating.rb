# == Schema Information
#
# Table name: ratings
#
#  rating     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_ratings_on_recipe_id_and_user_id  (recipe_id,user_id) UNIQUE
#
class Rating < ApplicationRecord
    belongs_to :user
    belongs_to :recipe

    validates :user, presence: true, uniqueness: { scope: :recipe }
    validates :recipe, presence: true, uniqueness: { scope: :user }
    validates :rating, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true }

end
