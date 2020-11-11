class AddGoogleUserIdToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :google_user_id, null: true, unique: true
    end
    
    change_column_null :users, :password_digest, true
  end
end
