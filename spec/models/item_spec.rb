require 'rails_helper'
# для запуска только этого файла (этой спеки) можно использовать > bundle exec rspec spec/models/item_spec.rb
RSpec.describe Item, type: :model do

  it {should validate_presence_of :name}
  it {should validate_numericality_of :price}
  it {should have_many :positions}
  it {should have_many :carts}
  it {should have_many :comments}
  it {should have_one :image}

  # it 'validates name' do
  #   # проверяем класс Item
  #   # validates :name, :description, presence: true
  #   # должно быть presence: true на name
  #   should validate_presence_of :name
  # end
  #
  # it 'validates price' do
  #   should validate_numericality_of :price
  # end
  #
  # # Ещё пример теста. Проверяем связи
  # it 'has many' do
  #   should have_many :positions
  #   should have_many :carts
  #   should have_many :comments
  # end
  #
  # it 'has one' do
  #   should have_one :image
  # end

end
