class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      # Корзина должна принадлежать конкретному юзеру
      t.integer :user_id
      t.timestamps
    end
  end
end
