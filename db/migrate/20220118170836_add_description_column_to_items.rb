class AddDescriptionColumnToItems < ActiveRecord::Migration[7.0]
  def change
    add_column(:items, :description, :string) # table_name :items, column_name: description, type:string
  end
end
