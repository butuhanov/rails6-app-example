class DeleteColumnItemIdFromImages < ActiveRecord::Migration[7.0]
  remove_column :images, :item_id
end
