class CreatePositions < ActiveRecord::Migration[7.0]
  def change
    create_table :positions do |t|
      t.integer :cart_id # корзина
      t.integer :item_id # товар
      t.integer :quantity # количество едениц
      t.timestamps
    end
  end
end
