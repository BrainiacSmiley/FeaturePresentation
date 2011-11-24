require 'spec_helper'

describe PagesController do
  render_views
  I18n.available_locales.each do |locale|
    I18n.locale = locale

    describe "GET 'home'" do
      before(:each) do
        get :home
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
         response.should have_selector('title', :content => I18n.t(:title))
      end
    end
  end
end
