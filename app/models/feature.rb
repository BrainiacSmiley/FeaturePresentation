# == Schema Information
#
# Table name: features
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  example     :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Feature < ActiveRecord::Base
  attr_accessible :name, :example, :description

  belongs_to :feature_description

  validates :name,                   :presence => true
  validates :description,            :presence => true
  validates :feature_description_id, :presence => true
end
