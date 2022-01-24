class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string body
      t.integer user_id
      # t.integer item_id
      # t.integer blog_post_id # Предположим, что в будущем понадобится также оставлять комменты под постами в блоге
      # Т.о. пользователь может оставить коммент к товару либо к посту в блоге, но тогда в таблице будет много пустых
      # ячеек. Чтобы этого избежать вводятся полиморфные связи.
      t.integer commentable_id
      t.integer commentable_type
      t.timestamps
    end
  end
end
