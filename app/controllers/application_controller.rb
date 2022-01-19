class ApplicationController < ActionController::Base

  # Главный контроллер, от которого наследуются все остальные
  # всё добавленное здесь будет доступно в любом контроллере

  def render_403
    render file: 'public/403.html', status: :forbidden
  end

  def render_404
    render file: 'public/404.html', status: :not_found
  end

end
