class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  # Пример использования
  # > rails c
  # 2.7.3 :010 > Image.create(item_id: 31, file: '5.jpg', imageable_id: 30, imageable_type: 'Item') # id из имеющихся в БД
  #   Item Load (1.4ms)  SELECT "items".* FROM "items" WHERE "items"."id" = $1 LIMIT $2  [["id", 30], ["LIMIT", 1]]
  #   Image Create (1.8ms)  INSERT INTO "images" ("item_id", "file", "imageable_id", "imageable_type", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["item_id", 31], ["file", "5.jpg"], ["imageable_id", 30], ["imageable_type", "Item"], ["created_at", "2022-01-24 13:32:14.845018"], ["updated_at", "2022-01-24 13:32:14.845018"]]
  #  => #<Image:0x00007fc270502f78 id: 5, item_id: 31, file: "5.jpg", imageable_id: 30, imageable_type: "Item", created_at: Mon, 24 Jan 2022 13:32:14.845018000 UTC +00:00, updated_at: Mon, 24 Jan 2022 13:32:14.845018000 UTC +00:00>
  # 2.7.3 :011 >
  #
  # До использования Eager loading
  # Started GET "/items" for 127.0.0.1 at 2022-01-24 20:53:55 +0700
  # Rendering items/index.html.erb within layouts/application
  # Item Exists? (1.3ms)  SELECT 1 AS one FROM "items" LIMIT $1  [["LIMIT", 1]]
  # ↳ app/views/items/index.html.erb:2
  # Item Load (2.7ms)  SELECT "items".* FROM "items" ORDER BY "items"."id" ASC
  # ↳ app/views/items/index.html.erb:15
  # Image Load (4.0ms)  SELECT "images".* FROM "images" WHERE "images"."imageable_id" = $1 AND "images"."imageable_type" = $2 LIMIT $3  [["imageable_id", 27], ["imageable_type", "Item"], ["LIMIT", 1]]
  # ↳ app/views/items/index.html.erb:22
  # Image Load (1.5ms)  SELECT "images".* FROM "images" WHERE "images"."imageable_id" = $1 AND "images"."imageable_type" = $2 LIMIT $3  [["imageable_id", 29], ["imageable_type", "Item"], ["LIMIT", 1]]
  # ↳ app/views/items/index.html.erb:22
  # Image Load (2.8ms)  SELECT "images".* FROM "images" WHERE "images"."imageable_id" = $1 AND "images"."imageable_type" = $2 LIMIT $3  [["imageable_id", 30], ["imageable_type", "Item"], ["LIMIT", 1]]
  # ↳ app/views/items/index.html.erb:22
  # Image Load (1.2ms)  SELECT "images".* FROM "images" WHERE "images"."imageable_id" = $1 AND "images"."imageable_type" = $2 LIMIT $3  [["imageable_id", 31], ["imageable_type", "Item"], ["LIMIT", 1]]
  # ↳ app/views/items/index.html.erb:22
  # Image Load (1.1ms)  SELECT "images".* FROM "images" WHERE "images"."imageable_id" = $1 AND "images"."imageable_type" = $2 LIMIT $3  [["imageable_id", 32], ["imageable_type", "Item"], ["LIMIT", 1]]
  # ↳ app/views/items/index.html.erb:22
  # Rendered shared/_email.html.erb (Duration: 2.4ms | Allocations: 189)
  # Rendered items/index.html.erb within layouts/application (Duration: 1478.7ms | Allocations: 51482)
  # Rendered layout layouts/application.html.erb (Duration: 1509.6ms | Allocations: 65033)
  # Index endpoint
  # Completed 200 OK in 1799ms (Views: 1530.9ms | ActiveRecord: 40.1ms | Allocations: 75708)

  # После подключения Eager loading - количество запросов значительно снижается
  # Started GET "/items" for 127.0.0.1 at 2022-01-24 21:02:05 +0700
  # Rendering items/index.html.erb within layouts/application
  #   Item Exists? (5.3ms)  SELECT 1 AS one FROM "items" LIMIT $1  [["LIMIT", 1]]
  #   ↳ app/views/items/index.html.erb:2
  #   Item Load (2.5ms)  SELECT "items".* FROM "items" ORDER BY "items"."id" ASC
  #   ↳ app/views/items/index.html.erb:15
  #   Image Load (4.5ms)  SELECT "images".* FROM "images" WHERE "images"."imageable_type" = $1 AND "images"."imageable_id" IN ($2, $3, $4, $5, $6)  [["imageable_type", "Item"], ["imageable_id", 27], ["imageable_id", 29], ["imageable_id", 30], ["imageable_id", 31], ["imageable_id", 32]]
  #   ↳ app/views/items/index.html.erb:15
  #   Rendered shared/_email.html.erb (Duration: 1.0ms | Allocations: 189)
  #   Rendered items/index.html.erb within layouts/application (Duration: 1085.7ms | Allocations: 44388)
  #   Rendered layout layouts/application.html.erb (Duration: 1236.9ms | Allocations: 58009)
  # Index endpoint
  # Completed 200 OK in 1376ms (Views: 1220.3ms | ActiveRecord: 38.4ms | Allocations: 68697)
  end
