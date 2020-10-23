class CreateIngredient < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.string :units, null: false
    end
    add_index :ingredients, :name, unique: true
  end
end
