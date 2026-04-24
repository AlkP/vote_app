# == Schema Information
#
# Table name: answers
#
#  id           :integer          not null, primary key
#  vote         :integer          not null
#  apartment_id :integer          not null
#  question_id  :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_answers_on_apartment_id                  (apartment_id)
#  index_answers_on_apartment_id_and_question_id  (apartment_id,question_id) UNIQUE
#  index_answers_on_question_id                   (question_id)
#

class Answer < ApplicationRecord
  belongs_to :apartment
  belongs_to :question

  validates :apartment_id, uniqueness: { scope: :question_id }
  validates :vote, presence: true

  enum :vote, { yes: 1, no: 2, neutral: 3 }
end
