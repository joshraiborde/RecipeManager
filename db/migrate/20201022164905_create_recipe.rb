class CreateRecipe < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
    end
    add_index :categories, :name, unique: true
    
    create_table :recipes do |t|
      t.string :name, null: false
      t.references :categories, null: false, foreign_key: true
      t.integer :estimated_time
      t.text :directions
      t.timestamps
    end
    add_index :recipes, :name, unique: true
  end
end
