class UserDecorator < ApplicationDecorator

  # логика отображения имени
  #
  delegate_all # Делегировать неизвестные методы самому объекту который декорируем

  # Проверяем есть имя или нет, если его нет, то берём имя из почты
  def name_or_email
    return name if name.present?

    email.split('@')[0]
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
