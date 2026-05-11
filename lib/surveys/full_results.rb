class Surveys::FullResults < BaseLib
  attr_reader :survey, :results

  def initialize(survey)
    super()
    @survey = survey
  end

  private

  # TODO: вынес говно-код в lib
  def process
    survey.questions.map do |question|
      {
        question: question,
        results: votes_for_question(question)
      }
    end
  end

  def votes_for_question(question)
    fill_null_data
    fill_common_data(question)
    did_not_vote_percent_processing if question.absolute
    other_vote_percent_processing(question)

    results
  end

  def fill_null_data
    @results =
      {
        total_area: 0,
        votes: 0,
        yes: { area: 0, count: 0 },
        no: { area: 0, count: 0 },
        neutral: { area: 0, count: 0 },
        did_not_vote: { area: 0, count: 0 }
      }
  end

  def fill_common_data(question)
    question.answers.includes(:apartment).find_each do |answer|
      area = answer.apartment.area.to_f
      next if area.zero?

      results[answer.vote.to_sym][:area] += area
      results[answer.vote.to_sym][:count] += 1
      next if question.absolute

      results[:total_area] += area
    end
  end

  def did_not_vote_percent_processing
    results[:total_area] = full_area
    results[:did_not_vote][:area] = full_area - yes_no_neutral_areas
    results[:did_not_vote][:count] = full_votes - yes_no_neutral_counts
    results[:did_not_vote][:percent] = results[:total_area].positive? ? (results[:did_not_vote][:area] / results[:total_area] * 100).round(1) : 0
  end

  def other_vote_percent_processing(question)
    results[:yes][:percent] = results[:total_area].positive? ? (results[:yes][:area] / results[:total_area] * 100).round(1) : 0
    results[:no][:percent] = results[:total_area].positive? ? (results[:no][:area] / results[:total_area] * 100).round(1) : 0
    results[:neutral][:percent] = results[:total_area].positive? ? (results[:neutral][:area] / results[:total_area] * 100).round(1) : 0
    results[:votes] = question.absolute ? full_votes : yes_no_neutral_counts
  end

  def full_area
    @full_area ||= Apartment.full_area
  end

  def full_votes
    @full_votes ||= Apartment.full_votes
  end

  def yes_no_neutral_areas
    results[:yes][:area] + results[:no][:area] + results[:neutral][:area]
  end

  def yes_no_neutral_counts
    results[:yes][:count] + results[:no][:count] + results[:neutral][:count]
  end
end
