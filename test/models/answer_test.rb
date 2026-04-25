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

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
