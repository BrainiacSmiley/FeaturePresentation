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

require 'spec_helper'

describe FeatureDescription do
  before(:each) do
    @attr = {
      :name => "New FeatureDescription",
      :description => "New Description for FeatureDescription"
    }
  end
  
  it "should create a new instance given valid attributes" do
    FeatureDescription.create!(@attr)
  end

  it "should require a name" do
    no_name_feature_description = FeatureDescription.new(@attr.merge(:name => ""))
    no_name_feature_description.should_not be_valid
  end

  describe "feature association" do
    before(:each) do
      @feature_description = FeatureDescription.create(@attr)
      @feature1 = Factory(:feature, :feature_description => @feature_description, :name => "Feature 1")
      @feature2 = Factory(:feature, :feature_description => @feature_description, :name => "Feature 2")
    end

    it "should have a features attribute" do
      @feature_description.should respond_to(:features)
    end

    it "should destroy associated features" do
      @feature_description.destroy
      [@feature1, @feature2].each do |feature|
        Feature.find_by_id(feature.id).should be_nil
      end
    end
  end
end
