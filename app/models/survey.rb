# == Schema Information
#
# Table name: surveys
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Survey < ApplicationRecord
  has_many :questions, dependent: :destroy

  # TODO: немного гавно-кода
  def votes_for_question(question_id)
    question = questions.find(question_id)

    results = {
      total_area: 0,
      yes: { area: 0, count: 0 },
      no: { area: 0, count: 0 },
      neutral: { area: 0, count: 0 }
    }

    question.answers.includes(:apartment).find_each do |answer|
      area = answer.apartment.area.to_f
      next if area.zero?

      results[:total_area] += area
      results[answer.vote.to_sym][:area] += area
      results[answer.vote.to_sym][:count] += 1
    end

    results[:yes][:percent] = results[:total_area].positive? ? (results[:yes][:area] / results[:total_area] * 100).round(1) : 0
    results[:no][:percent] = results[:total_area].positive? ? (results[:no][:area] / results[:total_area] * 100).round(1) : 0
    results[:neutral][:percent] = results[:total_area].positive? ? (results[:neutral][:area] / results[:total_area] * 100).round(1) : 0

    results
  end

  def full_results
    questions.map do |question|
      {
        question: question,
        results: votes_for_question(question.id)
      }
    end
  end
end
