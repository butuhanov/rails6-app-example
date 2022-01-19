class ItemsController < ApplicationController

  def index # эндпоинт index
    @items = Item.all # Объявляем инстансную переменную в которую поместим всё что есть в таблице Items
    # render text: @items.map do |i| # с помощью метода render вернём текст, где
    #   # перебираем элементы переменной items  с помощью метода map которому мы передадим блок
    #   "#{i.name}:#{i.price}"
    # end
  end
end
