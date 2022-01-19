class Item < ApplicationRecord

  validates :price, numericality: {greater_than: 0}

  # 2.7.3 :003 > Item.new(price:-2).save
  # => false
  #
  # 2.7.3 :004 > Item.new(price:2).save
  #   TRANSACTION (1.2ms)  BEGIN
  #   Item Create (2.6ms)  INSERT INTO "items" ("price", "name", "real", "weight", "created_at", "updated_at", "description") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["price", 2.0], ["name", nil], ["real", nil], ["weight", nil], ["created_at", "2022-01-19 04:47:40.984417"], ["updated_at", "2022-01-19 04:47:40.984417"], ["description", nil]]
  #   TRANSACTION (6.7ms)  COMMIT
  #  => true
  # 2.7.3 :005 >

end
