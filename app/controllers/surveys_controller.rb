class SurveysController < ApplicationController
  before_action :set_survey, only: %i[edit update destroy]

  def index
    @surveys = Survey.all.order(id: :desc)
  end

  def new
    @survey = Survey.new
  end

  def edit; end

  def create
    @survey = Survey.new(survey_params)

    if @survey.save
      redirect_to surveys_path, notice: "Survey was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @survey.update(survey_params)
      redirect_to surveys_path, notice: "Survey was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @survey.destroy!

    redirect_to surveys_path, notice: "Survey was successfully destroyed.", status: :see_other
  end

  private

  def set_survey
    @survey = Survey.find(params.expect(:id))
  end

  def survey_params
    params.expect(survey: [ :name, :description ])
  end
end
