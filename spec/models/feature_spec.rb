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

require 'spec_helper'

describe Feature do
  before(:each) do
    @attr = {
      :name        => "New Feature",
      :example     => "<html><h1>Test</h1></html>",
      :description => "New Description"
    }
  end

  it "should create a new instance given valid attributes" do
    Feature.create!(@attr)
  end

  it "should require a name" do
    no_name_feature = Feature.new(@attr.merge(:name => ""))
    no_name_feature.should_not be_valid
  end

  it "should require an examlpe" do
    no_example_feature = Feature.new(@attr.merge(:example => ""))
    no_example_feature.should_not be_valid
  end

  it "should require a description" do
    no_description_feature = Feature.new(@attr.merge(:description => ""))
    no_description_feature.should_not be_valid
  end
end
