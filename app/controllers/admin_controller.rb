class AdminController < ApplicationController
  before_action :admin?
  layout 'admin' # общий лэйаут для всех методов

  def users_count
    @users_count = User.count
    # render layout: 'application' # если хотим использовать индивидуальный лэйаут
  end
end
