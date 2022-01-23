class Cart < ApplicationRecord
  belongs_to :user # корзина принадлежит юзеру
end
