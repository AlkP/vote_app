class QuestionsController < ApplicationController
  before_action :set_survey, only: %i[index new edit create update destroy]
  before_action :set_question, only: %i[edit update destroy]

  def index
    @questions = @survey.questions
  end

  def new
    @question = @survey.questions.new
  end

  def edit; end

  def create
    @question = @survey.questions.new(question_params)

    if @question.save
      redirect_to survey_questions_path(@survey), notice: t('.create.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @question.update(question_params)
      redirect_to survey_questions_path(@survey), notice: t('.update.success'), status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @question.destroy!

    redirect_to survey_questions_path(@survey), notice: t('.destroy.success'), status: :see_other
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_question
    @question = Question.find(params.expect(:id))
  end

  def question_params
    params.expect(question: [:name])
  end
end
