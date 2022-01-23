class Cart < ApplicationRecord
  belongs_to :user, optional:true # корзина принадлежит юзеру

  # Без optional:true
  # 2.7.3 :012 > Cart.create.errors
  # => #<ActiveModel::Errors [#<ActiveModel::Error attribute=user, type=blank, options={:message=>:required}>]>
  # Добавляем  optional:true
  #    2.7.3 :001 > Cart.create.errors
  #    Cart Create (1.8ms)  INSERT INTO "carts" ("user_id", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["user_id", nil], ["created_at", "2022-01-23 16:27:58.527243"], ["updated_at", "2022-01-23 16:27:58.527243"]]
  #    => #<ActiveModel::Errors []>
  #
  # Добавляем товар в корзину
  #
  # 2.7.3 :006 > i1 = Item.create(name:'bike', price:200, description:'test')
  # 2.7.3 :007 > c1 = Cart.create
  # С помощью оператора пуш добавляем товар в корзину
  #
  # 2.7.3 :008 > c1.items << i1
  #   Cart::HABTM_Items Create (1.5ms)  INSERT INTO "carts_items" ("cart_id", "item_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4)  [["cart_id", 3], ["item_id", 24], ["created_at", "2022-01-23 16:42:18.344576"], ["updated_at", "2022-01-23 16:42:18.344576"]]
  #   Item Load (1.4ms)  SELECT "items".* FROM "items" INNER JOIN "carts_items" ON "items"."id" = "carts_items"."item_id" WHERE "carts_items"."cart_id" = $1  [["cart_id", 3]]
  # [#<Item:0x00005651b8436b00
  #   id: 24,
  #   price: 200.0,
  #   name: "bike",...
  # 2.7.3 :009 >
  #
  # Привяжем корзину к пользователю
  #
  # 2.7.3 :019 > u1 = User.first
  #
  # 2.7.3 :020 > c1.user = u1
  #
  # 2.7.3 :021 > u1.cart = c1
  #   Cart Update (1.5ms)  UPDATE "carts" SET "user_id" = $1, "updated_at" = $2 WHERE "carts"."id" = $3  [["user_id", 2], ["updated_at", "2022-01-23 16:48:57.788081"], ["id", 3]]
  #  => #<Cart:0x00007f46eccdf0c0 id: 3, user_id: 2, created_at: Sun, 23 Jan 2022 16:40:03.015557000 UTC +00:00, updated_at: Sun, 23 Jan 2022 16:48:57.788081000 UTC +00:00>
  # 2.7.3 :022 >


  has_and_belongs_to_many :items # в корзину можно поместить один и тот же товар, который будет принадлежать разным юзерам
end
