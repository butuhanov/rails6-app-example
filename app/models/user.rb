class User < ApplicationRecord
  has_one :cart, dependent: :destroy # юзер имеет одну корзину, при удалении юзера её нужно удалить тоже
end
# > rails c
#
# 2.7.3 :001 > u = User.create(login: 'testuser')
# User Create (1.1ms)  INSERT INTO "users" ("login", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["login", "testuser"],...
# => #<User:0x000055910ae6feb0 id: 1, login: "testuser", created_at: Sun, 23 Jan 2022
#
#   2.7.3 :002 > c = Cart.create
# => #<Cart:0x00007f0df0cf8668 id: nil, user_id: nil, created_at: nil, updated_at: nil>
#
#   2.7.3 :003 > u.cart=c
# Cart Load (0.5ms)  SELECT "carts".* FROM "carts" WHERE "carts"."user_id" = $1 LIMIT $2  [["user_id", 1], ["LIMIT", 1]]
#  Cart Create (0.6ms)  INSERT INTO "carts" ("user_id", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["user_id", 1], ["created_at", "2022-01-23 12:09:25.808582"], ["updated_at", "2022-01-23 12:09:25.808582"]]
#  => #<Cart:0x00007f0df0cf8668 id: 1, user_id: 1, created_at: Sun, 23 Jan 2022 12:09:25.808582000 UTC +00:00, updated_at: Sun, 23 Jan 2022 12:09:25.808582000 UTC +00:00>
#
#   2.7.3 :004 > u.destroy
# Cart Destroy (1.4ms)  DELETE FROM "carts" WHERE "carts"."id" = $1  [["id", 1]]
# User Destroy (1.1ms)  DELETE FROM "users" WHERE "users"."id" = $1  [["id", 1]]
#  => #<User:0x000055910ae6feb0 id: 1, login: "testuser", created_at: Sun, 23 Jan 2022 12:08:46.688181000 UTC +00:00, updated_at: Sun, 23 Jan 2022 12:08:46.688181000 UTC +00:00>

