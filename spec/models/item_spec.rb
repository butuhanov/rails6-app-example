require 'rails_helper'
# для запуска только этого файла (этой спеки) можно использовать > bundle exec rspec spec/models/item_spec.rb
RSpec.describe Item, type: :model do

  it {should validate_presence_of :name}
  it {should validate_numericality_of :price}
  it {should have_many :positions}
  it {should have_many :carts}
  it {should have_many :comments}
  it {should have_one :image}


  context 'calculate price' do
    let!(:item1) {create :item, price:10}
    let!(:item2) {create :item, price:20}
    let!(:order) {create :order}

    it 'calculate price' do
    order.items << item1
    order.items << item2

    expect(order.calculate_total).to be 30.0
    end
  end

  # Так не надо делать, это просто пример, правильно - использовать фабрики
  # it 'calculate price' do
  #   item1 = Item.new(price:10)
  #   item2 = Item.new(price:20)
  #   order = Order.new
  #   order.items << item1
  #   order.items << item2
  #   order.calculate_total
  #   expect(order.total).to be 30.0
  # end

end
