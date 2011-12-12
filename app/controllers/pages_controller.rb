class PagesController < ApplicationController
  def home
    @title = t(:title)
    @feature_descriptions = FeatureDescription.all
  end
end
