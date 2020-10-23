class CreateRatingsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :recipes, :users, table_name: :ratings do |t|
      t.integer :rating, null: false
      t.index %i[recipe_id user_id], unique: true
      t.timestamps
    end
  end
end
