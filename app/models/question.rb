# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  name       :string
#  survey_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_questions_on_survey_id  (survey_id)
#

class Question < ApplicationRecord
  belongs_to :survey
  has_many   :answers
  has_many   :apartments, through: :answers
end
