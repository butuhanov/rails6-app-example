class Item < ApplicationRecord
  # Модель указывается в единственном числе, контроллер во множественном

  validates :price, numericality: {greater_than: 0, :allow_nil => :true }
  validates :name, :description, presence: true

  # Корзина может иметь неограниченное количество товаров
  # belongs_to cart будет означать что конкретный товар может находиться только в одной корзине
  # но один товар может быть добавлен разными пользователями
  # чтобы один и тот же товар мог находится в разных корзинах нужно использовать has_and_belongs_to_many
  # которые принадлежат разным пользователя
  # has_and_belongs_to_many :carts
  # Меняем на has many :through
  has_many :positions
  has_many :carts, through: :positions

  # 2.7.3 :003 > Item.new(price:-2).save
  # => false
  #
  # 2.7.3 :004 > Item.new(price:2).save
  #   TRANSACTION (1.2ms)  BEGIN
  #   Item Create (2.6ms)  INSERT INTO "items" ("price", "name", "real", "weight", "created_at", "updated_at", "description") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["price", 2.0], ["name", nil], ["real", nil], ["weight", nil], ["created_at", "2022-01-19 04:47:40.984417"], ["updated_at", "2022-01-19 04:47:40.984417"], ["description", nil]]
  #   TRANSACTION (6.7ms)  COMMIT
  #  => true
  # 2.7.3 :005 >

  # см. https://guides.rubyonrails.org/active_record_validations.html
  #

  has_many :comments, as: :commentable
  # Таким образом обозначаем что Item является комментируемым
  #

  has_one :image, as: :imageable

  # Callbacks
  # см. также https://guides.rubyonrails.org/active_record_callbacks.html
  after_initialize { p 'after initialize'} # Item.new
  # 2.7.3 :001 > Item.first
  # Item Load (2.0ms)  SELECT "items".* FROM "items" ORDER BY "items"."id" ASC LIMIT $1  [["LIMIT", 1]]
  # "after initialize"
  # => #<Item:0x00007f1aec488d08 id: 2, price: 45.0, name: "Dasha", real: nil, weight: nil, created_at: Wed, 19 Jan 2022 03:52:03.525779000 UTC +00:00, updated_at: Wed, 19 Jan 2022 04:00:39.576383000 UTC +00:00, description: nil>
  #   2.7.3 :002 >

  after_save { p 'after save'} # Item.save Item.create
  after_create { p 'after create'} # Item.create

  # 2.7.3 :004 > Item.create(price:2, name:'test',description:'for sale')
  # "after initialize"
  # TRANSACTION (1.1ms)  BEGIN
  #                        Item Create (0.9ms)  INSERT INTO "items" ("price", "name", "real", "weight", "created_at", "updated_at", "description") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["price", 2.0], ["name", "test"], ["real", nil], ["weight", nil], ["created_at", "2022-01-19 05:10:45.681885"], ["updated_at", "2022-01-19 05:10:45.681885"], ["description", "for sale"]]
  #                        "after create"
  #                        "after save"
  #                        TRANSACTION (1.7ms)  COMMIT
  #                        => #<Item:0x00007f1aec454ad0 id: 7, price: 2.0, name: "test", real: nil, weight: nil, created_at: Wed, 19 Jan 2022 05:10:45.681885000 UTC +00:00, updated_at: Wed, 19 Jan 2022 05:10:45.681885000 UTC +00:00, description: "for sale">
  after_update { p 'after update'} # Item.update
  # 2.7.3 :005 > Item.where(name:'test').update(name:'Dasha')
  # Item Load (0.5ms)  SELECT "items".* FROM "items" WHERE "items"."name" = $1  [["name", "test"]]
  # "after initialize"
  # TRANSACTION (0.4ms)  BEGIN
  #                        Item Update (0.8ms)  UPDATE "items" SET "name" = $1, "updated_at" = $2 WHERE "items"."id" = $3  [["name", "Dasha"], ["updated_at", "2022-01-19 05:12:40.949326"], ["id", 7]]
  #                        "after update"
  #                        "after save"
  #                        TRANSACTION (6.6ms)  COMMIT
  #                        => [#<Item:0x000055bfbf4c5660 id: 7, price: 2.0, name: "Dasha", real: nil, weight: nil, created_at: Wed, 19 Jan 2022 05:10:45.681885000 UTC +00:00, updated_at: Wed, 19 Jan 2022 05:12:40.949326000 UTC +00:00, description: "for sale">]
  #                          2.7.3 :006 >

   after_destroy { p 'after destroy'} # Item.destroy
  # 2.7.3 :006 > Item.where(name:'Dasha').destroy_all
  # Item Load (1.5ms)  SELECT "items".* FROM "items" WHERE "items"."name" = $1  [["name", "Dasha"]]
  # "after initialize"
  # "after initialize"
  # TRANSACTION (1.0ms)  BEGIN
  #                        Item Destroy (3.7ms)  DELETE FROM "items" WHERE "items"."id" = $1  [["id", 2]]
  #                        "after destroy"
  #                        TRANSACTION (1.3ms)  COMMIT
  #                        TRANSACTION (0.7ms)  BEGIN
  #                                               Item Destroy (1.0ms)  DELETE FROM "items" WHERE "items"."id" = $1  [["id", 7]]
  #                                               "after destroy"
  #                                               TRANSACTION (1.5ms)  COMMIT
  #                                               =>
  #                                                 [#<Item:0x000055bfbf1b0920 id: 2, price: 45.0, name: "Dasha", real: nil, weight: nil, created_at: Wed, 19 Jan 2022 03:52:03.525779000 UTC +00:00, updated_at: Wed, 19 Jan 2022 04:00:39.576383000 UTC +00:00, description: nil>,
  #                                                   #<Item:0x000055bfbf1b06f0 id: 7, price: 2.0, name: "Dasha", real: nil, weight: nil, created_at: Wed, 19 Jan 2022 05:10:45.681885000 UTC +00:00, updated_at: Wed, 19 Jan 2022 05:12:40.949326000 UTC +00:00, description: "for sale">]
  #                                                   2.7.3 :007 >


                                                end
