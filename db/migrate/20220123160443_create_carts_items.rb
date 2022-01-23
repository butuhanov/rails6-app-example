class CreateCartsItems < ActiveRecord::Migration[7.0]
  def change
    create_table :carts_items, id:false do |t|  # создаём таблицу join для связи двух таблиц, id для неё не нужен
      # после прогонки этой миграции связи заработают
      t.integer :cart_id
      t.integer :item_id
      t.timestamps
    end
  end
end
