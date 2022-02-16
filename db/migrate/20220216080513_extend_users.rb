class ExtendUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email, :string, null: false, index: true, unique: true
    add_column :users, :name, :string
    add_column :users, :password_digest, :string
  end
end
