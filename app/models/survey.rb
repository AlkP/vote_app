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

  def full_results
    Surveys::FullResults.call(self)
  end

  def total_apartments_area_efficient
    apartment_ids = questions.joins(:answers).select('answers.apartment_id')

    Apartment.where(id: apartment_ids).sum(:area)
  end
end
