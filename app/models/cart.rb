class Cart < ApplicationRecord
  belongs_to :user # корзина принадлежит юзеру
  has_and_belongs_to_many :items # в корзину можно поместить один и тот же товар, который будет принадлежать разным юзерам
end
