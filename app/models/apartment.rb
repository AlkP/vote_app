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

  validates :number, presence: true
end
