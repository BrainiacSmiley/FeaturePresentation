# == Schema Information
#
# Table name: feature_descriptions
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class FeatureDescription < ActiveRecord::Base
  attr_accessible :name, :description

  has_many :features, :dependent => :destroy

  validates :name, :presence => true
end
