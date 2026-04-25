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

require 'test_helper'

class ApartmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
