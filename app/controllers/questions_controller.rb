class QuestionsController < ApplicationController
  def show
    @question = Question.find_by id: params[:id]
  end

  def destroy
    @question = Question.find_by id: params[:id]
    @question.destroy
    redirect_to questions_path
  end

  def edit
    # Ищем вопрос который надо отредактировать.
    # params - объект со всеми параметрами запроса - id берется из маршрута routes.rb (/questions/:id/edit)
    @question = Question.find_by id: params[:id]
  end

  def update
    @question = Question.find_by id: params[:id]
    if @question.update question_params
      redirect_to questions_path
    else
      render :edit
    end
  end

  def index
    @questions = Question.all
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
end
