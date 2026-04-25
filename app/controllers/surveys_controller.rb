class SurveysController < ApplicationController
  before_action :set_survey, only: %i[edit update destroy results]

  def index
    @surveys = Survey.order(id: :desc)
  end

  def new
    @survey = Survey.new
  end

  def edit; end

  def create
    @survey = Survey.new(survey_params)

    if @survey.save
      redirect_to surveys_path, notice: t('.create.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @survey.update(survey_params)
      redirect_to surveys_path, notice: t('.update.success'), status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @survey.destroy!

    redirect_to surveys_path, notice: t('.destroy.success'), status: :see_other
  end

  def results
    @results = @survey.full_results
  end

  private

  def set_survey
    @survey = Survey.find(params.expect(:id))
  end

  def survey_params
    params.expect(survey: %i[name description])
  end
end
