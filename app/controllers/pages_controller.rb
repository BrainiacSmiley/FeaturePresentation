class PagesController < ApplicationController
  def home
    @feature_descriptions = FeatureDescription.all
  end

  def test
    @feature_descriptions = FeatureDescription.all
  end
end
