require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'validates price' do
    # проверяем класс Item
    # validates :name, :description, presence: true
    # должно быть presence: true на name
    should validate_presence_of :name
  end
end
