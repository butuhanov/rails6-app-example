require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'validates price' do
    # проверяем класс Item
    # validates :name, :description, presence: true
    # должно быть presence: true на name
    should validate_presence_of :name
  end

  # Ещё пример теста. Проверяем связи
  it 'has many' do
    should have_many :positions
    should have_many :carts
    should have_many :comments
  end

  it 'has one' do
    should have_one :image
  end
end
