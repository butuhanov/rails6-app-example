class QuestionsController < ApplicationController

  before_action :set_question!, only: %i[show destroy edit update]
  # Перед этими четырьмя методами будет запускаться set_question!

  def show
    # Привязываем ответы к вопросу
    # @answer = @question.answers.build
    # @pagy, @answers = pagy @question.answers.order(created_at: :desc)
    # # Answer.where(question: @question).limit(2).order(created_at: :desc)
    #
    # Используем декораторы
    @question = @question.decorate
    @answer = @question.answers.build
    @pagy, @answers = pagy @question.answers.order(created_at: :desc)
    @answers = @answers.decorate
  end

  def destroy
    @question.destroy
    flash[:success] = "Question deleted!"
    redirect_to questions_path
  end

  def edit
    # Ищем вопрос который надо отредактировать.
    # params - объект со всеми параметрами запроса - id берется из маршрута routes.rb (/questions/:id/edit)
    #  @question = Question.find_by id: params[:id]
  end

  def update
    if @question.update question_params
      flash[:success] = "Question updated!"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def index
    @pagy, @questions = pagy Question.order(created_at: :desc)
    @questions = @questions.decorate
  end

  def new
    # Инстанцируем новую запись, новый образец класса.
    @question = Question.new
  end

  def create
    # render plain: params # Если не нужно выводить на экран представление по умолчанию, пишем явно что нужно,
    # например просто текст

    @question = Question.new question_params # Будет создан образец класса Question с параметрами
    if @question.save # Если получилось сохранить то делаем редирект 302
      flash[:success] = "Question created!"
      redirect_to questions_path # Редирект на страницу со всеми вопросами
    else
      render :new
    end
  end

  private

  # Определяем, что нужно вытащить из присланных параметров
  def question_params
    # Находим в присланных параметрах question и из этих параметров достаём только title и body
    # Таким образом фильтруем всё что присылает клиент
    params.require(:question).permit(:title, :body)
  end

  # Выносим повторяющийся блок
  # ! используем для того чтобы указать, что метод опасный и может вызвать ошибку (если id не найден)
  def set_question!
    @question = Question.find params[:id]
  end
end
