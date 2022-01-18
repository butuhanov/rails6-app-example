class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.float :price
      t.string :name
      t.boolean :real
      t.float :weight
      t.timestamps
    end
  end
end
