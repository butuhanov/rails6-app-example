class ApplicationController < ActionController::Base

  include Pagy::Backend
  include ErrorHandling
  include Authentication
  #
  # # Добавляем обработку ошибок
  # include ErrorHandling
  #
  # include Pagy::Backend
  #
  # # Главный контроллер, от которого наследуются все остальные
  # # всё добавленное здесь будет доступно в любом контроллере
  #
  # def render_403
  #   render file: 'public/403.html', status: :forbidden
  # end
  #
  # def render_404
  #   render file: 'public/404.html', status: :not_found
  # end
  #
  # # Проверка админских прав
  # def admin?
  #   # render json: 'Access denied', status: :forbidden unless current_user.admin
  #   # ниже временная заглушка для теста, пока не реализован current_user
  #   # Проверка http://127.0.0.1:3000/items/13/edit?admin=1
  #   # render json: 'Access denied', status: :forbidden unless params[:admin]
  #   # true # временно всегда истина
  #   render_403 unless  params[:admin]
  # end
  #
  #
  # private
  #
  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id]).decorate if session[:user_id].present?
  # end
  #
  # def user_signed_in?
  #   current_user.present?
  # end
  #
  # helper_method :current_user, :user_signed_in?

end
