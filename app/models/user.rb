class User < ApplicationRecord
  has_one :cart, dependent: :destroy # юзер имеет одну корзину, при удалении юзера её нужно удалить тоже

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

  has_many :orders, dependent: :destroy

  # > rails c
  # Пример отображения ошибки объекта
  # 2.7.3 :008 > o=Order.new
  # => #<Order:0x000055dbb5007b20 id: nil, user_id: nil, created_at: nil, updated_at: nil>
  #   2.7.3 :009 > o.save
  # => false
  # 2.7.3 :010 > o.errors
  # => #<ActiveModel::Errors [#<ActiveModel::Error attribute=user, type=blank, options={:message=>:required}>]>
  #   2.7.3 :011 >
  #
  # Пользователи
  #
  # 2.7.3 :002 > u = User.create(login:'masha')
  #   User Create (2.5ms)  INSERT INTO "users" ("login", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["login", "masha"], ["created_at", "2022-01-23 14:53:59.915549"], ["updated_at", "2022-01-23 14:53:59.915549"]]
  #  => #<User:0x000055dbb4f85bc0 id: 2, login: "masha", created_at: Sun, 23 Jan 2022 14:53:59.915549000 UTC +00:00, updated_at: Sun, 23 Jan 2022 14:53:59.915549000 UTC +00:00>

  # 2.7.3 :003 > u = User.create(login:'dasha')
  #   User Create (1.4ms)  INSERT INTO "users" ("login", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["login", "dasha"], ["created_at", "2022-01-23 14:54:06.527011"], ["updated_at", "2022-01-23 14:54:06.527011"]]
  #  => #<User:0x000055dbb4dfc010 id: 3, login: "dasha", created_at: Sun, 23 Jan 2022 14:54:06.527011000 UTC +00:00, updated_at: Sun, 23 Jan 2022 14:54:06.527011000 UTC +00:00>
  # 2.7.3 :004 >

  # Пара способов присвоить переменным имеющихся пользователей
  # 2.7.3 :016 > u_1=User.where(id:2)
  # User Load (7.6ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1  [["id", 2]]
  # => [#<User:0x000055dbb34ad460 id: 2, login: "masha", created_at: Sun, 23 Jan 2022 14:53:59.915549000 UTC +00:00, updated_at: Sun, 23 Jan 2022 14:53:59.915549000 UTC +00:00>]
  #
  # 2.7.3 :017 > u_2=User.last
  # User Load (0.7ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" DESC LIMIT $1  [["LIMIT", 1]]
  # => #<User:0x000055dbb4f29348 id: 3, login: "dasha", created_at: Sun, 23 Jan 2022 14:54:06.527011000 UTC +00:00, updated_at: Sun, 23 Jan 2022 14:54:06.527011000 UTC +00:00>
  #   2.7.3 :018 >
  #
  # Создание заказов
  #2.7.3 :019 > u_1
  #  => [#<User:0x000055dbb34ad460 id: 2, login: "masha", created_at: Sun, 23 Jan 2022 14:53:59.915549000 UTC +00:00, updated_at: Sun, 23 Jan 2022 14:53:59.915549000 UTC +00:00>]
  # 2.7.3 :020 > u_2
  #  => #<User:0x000055dbb4f29348 id: 3, login: "dasha", created_at: Sun, 23 Jan 2022 14:54:06.527011000 UTC +00:00, updated_at: Sun, 23 Jan 2022 14:54:06.527011000 UTC +00:00>
  # 2.7.3 :021 > o_1=Order.create(user: u_1[0])
  #  Order Create (11.0ms)  INSERT INTO "orders" ("user_id", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["user_id", 2], ["created_at", "2022-01-23 15:37:50.278154"], ["updated_at", "2022-01-23 15:37:50.278154"]]
  # => #<Order:0x000055dbb4fd94a0 id: 1, user_id: 2, created_at: Sun, 23 Jan 2022 15:37:50.278154000 UTC +00:00, updated_at: Sun, 23 Jan 2022 15:37:50.278154000 UTC +00:00>
  # 2.7.3 :023 > o_3=Order.create(user: u_2)
  #   Order Create (0.6ms)  INSERT INTO "orders" ("user_id", "created_at", "updated_at") VALUES ($1, $2, $3) RETURNING "id"  [["user_id", 3], ["created_at", "2022-01-23 15:38:12.268576"], ["updated_at", "2022-01-23 15:38:12.268576"]]
  #  => #<Order:0x000055dbb3e240e8 id: 3, user_id: 3, created_at: Sun, 23 Jan 2022 15:38:12.268576000 UTC +00:00, updated_at: Sun, 23 Jan 2022 15:38:12.268576000 UTC +00:00>
  #
  # Вывести заказы пользователя
  # 2.7.3 :030 > u_2.orders
  #  =>
  # [#<Order:0x00007fabdc7f6ae0 id: 3, user_id: 3, created_at: Sun, 23 Jan 2022 15:38:12.268576000 UTC +00:00, updated_at: Sun, 23 Jan 2022 15:38:12.268576000 UTC +00:00>,
  #  #<Order:0x00007fabdc7f68d8 id: 4, user_id: 3, created_at: Sun, 23 Jan 2022 15:38:18.365121000 UTC +00:00, updated_at: Sun, 23 Jan 2022 15:38:18.365121000 UTC +00:00>,
  #  #<Order:0x00007fabdc7f6748 id: 5, user_id: 3, created_at: Sun, 23 Jan 2022 15:38:22.247175000 UTC +00:00, updated_at: Sun, 23 Jan 2022 15:38:22.247175000 UTC +00:00>]
  # 2.7.3 :031 >
  # 2.7.3 :032 > User.first.orders
  #   User Load (1.4ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
  #   Order Load (1.2ms)  SELECT "orders".* FROM "orders" WHERE "orders"."user_id" = $1  [["user_id", 2]]
  #  =>



end