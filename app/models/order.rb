class Order < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :items

  def calculate_total
    # создаем дополнительный виртуальный аттрибут для модели
    # перебираем items, его цены и суммируем эти цены между собой
    write_attribute :total, items.map(&:price).inject(:+)
  end
end
