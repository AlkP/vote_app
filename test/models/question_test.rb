# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  name       :string
#  survey_id  :integer          not null
#  updated_at :datetime         not null
#  absolute   :boolean          default(FALSE), not null
#
# Indexes
#
#  index_questions_on_survey_id  (survey_id)
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
