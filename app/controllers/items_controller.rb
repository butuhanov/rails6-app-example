class ItemsController < ApplicationController
  # Модель указывается в единственном числе, контроллер во множественном

  layout false # не требовать подключения вью

  skip_before_action :verify_authenticity_token # не проверять токен безопасности,
  # иначе при пост запросе через курл получаем ошибку ActionController::InvalidAuthenticityToken

  before_action :find_item, only: %i[show edit update destroy]  # выполнять приватный метод
  # перед перечисленными

  def index # эндпоинт index
    @items = Item.all # Объявляем инстансную переменную в которую поместим всё что есть в таблице Items
      # render body: @items.map {|i| "#{i.name}:#{i.price}"}
  end

  def create
    item = Item.create(items_params)
    # Проверка с помощью curl
    # > curl -d "name=curl_post&price=130&description=via%20curl" -X POST http://localhost:3000/items

    # ДОбавляем ответ в зависимости от успешности сохранения
    if item.persisted?
      # render json: item.name, status: :created
      redirect_to items_path
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def new;   end

  def show;
      render body: "Not found", status: 404  unless @item
  end

  def edit;
      render body: "Not found", status: 404  unless @item
  end

  def update;
    if @item.update(items_params)
    redirect_to item_path
    else
      render json: item.errors, status: :unprocessable_entity
      end
  end

  def destroy;
    if @item.destroy.destroyed?
      redirect_to items_path # делаем редирект на индексную страницу
    else
      render json: item.errors, status: :unprocessable_entity
    end

  end

  # При добавлении в БД нужно проверять что туда пишется
  # для этого создаём приватный метод items_params

  private

  def items_params
    # параметры которые хотим сохранять, которые будут доступны
    params.permit(:name, :price, :real, :weight, :description)
  end

  # Поиск по id нужного элемента, над которым требуется произвести действие
  # для обеспечения принципа DRY
  def find_item
    @item = Item.where(id: params[:id]).first
  end
end
