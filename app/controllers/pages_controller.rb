class PagesController < ApplicationController
  def home
    @features = Feature.all
  end
end
