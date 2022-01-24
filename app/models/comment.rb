class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  # Пример
  #
  #  2.7.3 :001 > i = Item.create(name:'car', price:'100', description:'test')
  #  2.7.3 :002 > i = Item.create(name:'bike', price:'200', description:'test')
  # 2.7.3 :003 > u = User.create(login:'masha')
  # 2.7.3 :004 > u = User.create(login:'dasha')
  # 2.7.3 :005 > b = BlogPost.create(title:'Title', body:'Text')
  # Далее добавим к первому товару комментарий
  # 2.7.3 :006 > i = Item.first
  #
  # 2.7.3 :007 > i.comments << Comment.new(user_id: User.first.id, body:'item comment')
  #   User Load (0.8ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1  [["LIMIT", 1]]
  #   User Load (0.7ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 2], ["LIMIT", 1]]
  #   Comment Create (1.7ms)  INSERT INTO "comments" ("body", "user_id", "commentable_id", "commentable_type", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["body", "item comment"], ["user_id", 2], ["commentable_id", 27], ["commentable_type", "Item"], ["created_at", "2022-01-24 03:19:51.145155"], ["updated_at", "2022-01-24 03:19:51.145155"]]
  #   Comment Load (1.0ms)  SELECT "comments".* FROM "comments" WHERE "comments"."commentable_id" = $1 AND "comments"."commentable_type" = $2  [["commentable_id", 27], ["commentable_type", "Item"]]
  #  =>
  # [#<Comment:0x0000560b2c5c1b28
  #   id: 1,
  #   body: "item comment",
  #   user_id: 2,
  #   commentable_id: 27,
  #   commentable_type: "Item",
  #   created_at: Mon, 24 Jan 2022 03:19:51.145155000 UTC +00:00,
  #   updated_at: Mon, 24 Jan 2022 03:19:51.145155000 UTC +00:00>]
  # 2.7.3 :008 >
  #
  # 2.7.3 :008 > i.comments << Comment.new(user_id: User.second.id, body:'item comment second user')
  #   User Load (1.2ms)  SELECT "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT $1 OFFSET $2  [["LIMIT", 1], ["OFFSET", 1]]
  #   TRANSACTION (0.9ms)  BEGIN
  #   User Load (1.0ms)  SELECT "users".* FROM "users" WHERE "users"."id" = $1 LIMIT $2  [["id", 3], ["LIMIT", 1]]
  #   Comment Create (1.5ms)  INSERT INTO "comments" ("body", "user_id", "commentable_id", "commentable_type", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6) RETURNING "id"  [["body", "item comment second user"], ["user_id", 3], ["commentable_id", 27], ["commentable_type", "Item"], ["created_at", "2022-01-24 03:20:58.573810"], ["updated_at", "2022-01-24 03:20:58.573810"]]
  #   TRANSACTION (13.7ms)  COMMIT
  #  =>
  # [#<Comment:0x0000560b2c5c1b28
  #   id: 1,
  #   body: "item comment",
  #   user_id: 2,
  #   commentable_id: 27,
  #   commentable_type: "Item",
  #   created_at: Mon, 24 Jan 2022 03:19:51.145155000 UTC +00:00,
  #   updated_at: Mon, 24 Jan 2022 03:19:51.145155000 UTC +00:00>,
  #  #<Comment:0x0000560b2b2a61d8
  #   id: 2,
  #   body: "item comment second user",
  #   user_id: 3,
  #   commentable_id: 27,
  #   commentable_type: "Item",
  #   created_at: Mon, 24 Jan 2022 03:20:58.573810000 UTC +00:00,
  #   updated_at: Mon, 24 Jan 2022 03:20:58.573810000 UTC +00:00>]
  # 2.7.3 :009 >
  #
  # 2.7.3 :008 > i.comments << Comment.new(user_id: User.second.id, body:'item comment second user')
  #
  # 2.7.3 :010 > b.comments << Comment.new(user_id: User.first.id, body:'blog comment')
  # 2.7.3 :011 > b.comments << Comment.new(user_id: User.second.id, body:'blog comment second')
  #
  # Посмотреть комментарии Item
  # 2.7.3 :012 > i.comments
  # Посмотреть комментарии BlogPost
  # 2.7.3 :013 > b.comments


end
