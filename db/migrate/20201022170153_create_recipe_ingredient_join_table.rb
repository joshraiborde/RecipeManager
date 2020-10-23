class CreateRecipeIngredientJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :recipes, :ingredients, table_name: :recipe_ingredients do |t|
      t.numeric :quantity, null: false
      t.index %i[recipe_id ingredient_id], unique: true
    end
  end
end
