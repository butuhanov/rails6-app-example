class Position < ApplicationRecord
  belongs_to :cart
  belongs_to :item

  # Пример использования
  #
  # 2.7.3 :002 > cart = Cart.create
  #   Cart Create (1.8ms)  INSERT INTO "carts" ("user_id", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["user_id", nil], ["created_at", "2022-01-23 17:30:39.265241"], ["updated_at", "2022-01-23 17:30:39.265241"]]
  #  => #<Cart:0x0000558a0d988cc0 id: 5, user_id: nil, created_at: Sun, 23 Jan 2022 17:30:39.265241000 UTC +00:00, updated_at: Sun, 23 Jan 2022 17:30:39.265241000 UTC +00:00>
  #
  # 2.7.3 :003 > items = Item.all
  #   Item Load (1.6ms)  SELECT "items".* FROM "items"
  #
  # 2.7.3 :004 > position = Position.create(item_id:items.first.id, cart_id:cart.id, quantity:5)
  #   TRANSACTION (0.7ms)  BEGIN
  #   Cart Load (1.1ms)  SELECT "carts".* FROM "carts" WHERE "carts"."id" = $1 LIMIT $2  [["id", 5], ["LIMIT", 1]]
  #   Item Load (1.1ms)  SELECT "items".* FROM "items" WHERE "items"."id" = $1 LIMIT $2  [["id", 27], ["LIMIT", 1]]
  # "after initialize"
  #   Position Create (2.6ms)  INSERT INTO "positions" ("cart_id", "item_id", "quantity", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["cart_id", 5], ["item_id", 27], ["quantity", 5], ["created_at", "2022-01-23 17:33:15.921383"], ["updated_at", "2022-01-23 17:33:15.921383"]]
  #   TRANSACTION (1.2ms)  COMMIT
  #  => #<Position:0x0000558a0d7328b8 id: 1, cart_id: 5, item_id: 27, quantity: 5, created_at: Sun, 23 Jan 2022 17:33:15.921383000 UTC +00:00, updated_at: Sun, 23 Jan 2022 17:33:15.921383000 UTC +00:00>
  # 2.7.3 :005 >
  #
  # 2.7.3 :005 > cart.items
  #   Item Load (1.0ms)  SELECT "items".* FROM "items" INNER JOIN "positions" ON "items"."id" = "positions"."item_id" WHERE "positions"."cart_id" = $1  [["cart_id", 5]]
  # "after initialize"
  #  =>
  # [#<Item:0x00007f22703fa2e8
  #   id: 27,
  #   price: 120.0,
  #   name: "car",
  #   real: nil,
  #   weight: nil,
  #   created_at: Sun, 23 Jan 2022 17:07:17.479059000 UTC +00:00,
  #   updated_at: Sun, 23 Jan 2022 17:07:17.479059000 UTC +00:00,
  #   description: "1",
  #   votes_count: 0>]
  # 2.7.3 :006 >
  #2.7.3 :006 > cart.positions
  #   Position Load (1.1ms)  SELECT "positions".* FROM "positions" WHERE "positions"."cart_id" = $1  [["cart_id", 5]]
  #  => [#<Position:0x00007f22707780a0 id: 1, cart_id: 5, item_id: 27, quantity: 5, created_at: Sun, 23 Jan 2022 17:33:15.921383000 UTC +00:00, updated_at: Sun, 23 Jan 2022 17:33:15.921383000 UTC +00:00>]
  # 2.7.3 :007 >
end
