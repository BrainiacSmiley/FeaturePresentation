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
    @feature_description = Factory(:feature_description)
    @attr = {
      :name        => "New Feature",
      :example     => "<h1>Test</h1>",
      :description => "New Description"
    }
  end

  it "should create a new instance given valid attributes" do
    @feature_description.features.create!(@attr)
  end

  describe "association" do
    before(:each) do
      @feature = @feature_description.features.create(@attr)
    end

    it "should have a user attribute" do
      @feature.should respond_to(:feature_description)
    end

    it "should have the right associated user" do
      @feature.feature_description_id.should == @feature_description.id
      @feature.feature_description.should == @feature_description
    end
  end

  describe "validations" do
    it "should require a feature_description_id" do
      Feature.new(@attr).should_not be_valid
    end

    it "should require a name" do
      @feature_description.features.build(@attr.merge(:name => ""))
      .should_not be_valid
    end

    it "should require an examlpe" do
      @feature_description.features.build(@attr.merge(:example => ""))
      .should_not be_valid
    end

    it "should require a description" do
      @feature_description.features.build(@attr.merge(:description => ""))
      .should_not be_valid
    end
  end
end
