class ItemsController < ApplicationController
  # Модель указывается в единственном числе, контроллер во множественном

  # layout false # не требовать подключения вью

  skip_before_action :verify_authenticity_token # не проверять токен безопасности,
  # иначе при пост запросе через курл получаем ошибку ActionController::InvalidAuthenticityToken

  before_action :find_item, only: %i[show edit update destroy upvote]  # выполнять приватный метод
  # перед перечисленными

  before_action :admin?, only: %i[edit] # проверять для этих эндпоинтов достаточность прав

  after_action :show_info,  only: %i[index]

  def index # эндпоинт index
    # @items = Item.all.order(:votes_count)
    # @items = Item.all.order('votes_count DESC', 'price DESC').limit 3
      # render body: @items.map {|i| "#{i.name}:#{i.price}"}
      # Примеры where
      #  @items = Item.where(name:'car', price:200, votes_count:0)
      #  @items = Item.where('price>=200 OR votes_count>2')
      #  @items = Item.where('price>=? OR votes_count>2', params[:price_from])
      # см. также https://www.rubyguides.com/2019/07/rails-where-method/
      # https://guides.rubyonrails.org/active_record_querying.html
    #
    # Для пустого запроса выводить всё
    @items = Item
    @items = @items.where('price>=?', params[:price_from]) if params[:price_from]
    @items = @items.where('created_at >=?', 1.day.ago) if params[:today]
    @items = @items.where('votes_count >=?', params[:votes_from]) if params[:votes_from]
    @items = @items.order(:id)

    # Используем механизм жадной загрузки - eager loading
    @items = @items.includes(:image)
  end

  def create
    @item = Item.create(items_params)
    # Проверка с помощью curl
    # > curl -d "name=curl_post&price=130&description=via%20curl" -X POST http://localhost:3000/items

    # ДОбавляем ответ в зависимости от успешности сохранения
    if @item.persisted?
      # render json: item.name, status: :created
      flash[:success] = "Item was saved"
      redirect_to items_path
    else
      flash.now[:error] = "Please fill all fields correctly"
      render :new
    end
  end

  def new
    @item = Item.new
  end

  def show;
      render body: "Not found", status: 404  unless @item
  end

  def edit;
      render body: "Not found", status: 404  unless @item
  end

  def update;
    if @item.update(items_params)
      flash[:success] = "Item was updated"
    redirect_to item_path
    else
      flash.now[:error] = "Please fill all fields correctly"
      render json: item.errors, status: :unprocessable_entity
      end
  end

  def destroy;
    if @item.destroy.destroyed?
      flash[:success] = "Item was deleted"
      redirect_to items_path # делаем редирект на индексную страницу
    else
      flash.now[:error] = "Item wasn't deleted"
      render json: item.errors, status: :unprocessable_entity
    end

  end

  def upvote
    @item.increment! :votes_count # увеличим на единицу поле votes_count
    redirect_to items_path # редирект на индексную страницу
  end

  def expensive
    @items = Item.where('price>50')
    render :index
  end


  private
  # При добавлении в БД нужно проверять что туда пишется
  # для этого создаём приватный метод items_params
  def items_params
    # параметры которые хотим сохранять, которые будут доступны
    params.permit(:name, :price, :real, :weight, :description)
  end

  # Поиск по id нужного элемента, над которым требуется произвести действие
  # для обеспечения принципа DRY
  def find_item
    @item = Item.where(id: params[:id]).first
    render_404 unless @item
  end



  def show_info
    puts "Index endpoint"
  end

end
