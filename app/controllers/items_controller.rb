class ItemsController < ApplicationController

  def index # эндпоинт index
    @items = Item.all # Объявляем инстансную переменную в которую поместим всё что есть в таблице Items
    render body: @items.map {|i| "#{i.name}:#{i.price}"}
  end
end
