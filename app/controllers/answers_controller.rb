class AnswersController < ApplicationController
  before_action :set_survey
  before_action :set_apartments
  before_action :set_questions

  def edit
    @answers = Answer.where(
      apartment_id: @apartments.pluck(:id),
      question_id: @questions.pluck(:id)
    ).index_by { |a| [a.apartment_id, a.question_id] }
  end

  def update
    answers_params = params[:answers] || {}
    Answer.transaction do
      answers_params.each do |key, vote_value|
        apartment_id, question_id = key.split("_").map(&:to_i)
        next if vote_value.blank?

        answer = Answer.find_or_initialize_by(
          apartment_id: apartment_id,
          question_id: question_id
        )

        answer.vote = vote_value
        answer.save!
      end
    end

    redirect_to survey_answers_path(@survey), notice: "Answers successfully updated."
  rescue => e
    redirect_to survey_answers_path(@survey), alert: "Error: #{e.message}"
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_apartments
    @apartments = Apartment.where(fragmented: false).order(:number, :prefix)
  end

  def set_questions
    @questions = @survey.questions.order(:id)
  end
end