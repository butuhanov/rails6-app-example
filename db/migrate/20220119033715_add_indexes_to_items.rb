class AddIndexesToItems < ActiveRecord::Migration[7.0]
  def change
    add_index :items, :price
    add_index :items, :name
  end
end
