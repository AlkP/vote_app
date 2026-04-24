# == Schema Information
#
# Table name: apartments
#
#  id                  :integer          not null, primary key
#  area                :float
#  created_at          :datetime         not null
#  fragmented          :boolean          default(FALSE), not null
#  name                :string
#  number              :string           not null
#  parent_apartment_id :integer
#  prefix              :string
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_apartments_on_number               (number)
#  index_apartments_on_parent_apartment_id  (parent_apartment_id)
#

class Apartment < ApplicationRecord
  belongs_to :parent_apartment, class_name: "Apartment", optional: true
  has_many   :child_apartments, class_name: "Apartment", foreign_key: "parent_apartment_id"
  has_many   :answers
  has_many   :questions, through: :answers

  validates :number, presence: true

  scope :by_number, ->(number) { where(number: number) }
  scope :by_prefix, ->(prefix) { where(prefix: prefix) }

  def area_mismatch?
    return false unless fragmented
    return false if child_apartments.empty?

    total_child_area = child_apartments.sum(:area).to_f
    area.to_f != total_child_area
  end

  def area_difference
    return 0 unless fragmented

    total_child_area = child_apartments.sum(:area).to_f
    area.to_f - total_child_area
  end
end
