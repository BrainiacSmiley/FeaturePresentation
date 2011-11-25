require 'spec_helper'

describe "LayoutLinks" do
  I18n.available_locales.each do |locale|
    I18n.locale = locale

    it "should have a Home page at '/'" do
      get '/'
      response.should have_selector('title', :content => I18n.t(:title))
    end

    describe "when not signed in" do
      it "should have a admin link" do
        visit root_path
        response.should have_selector('a', :href => login_path, :content => I18n.t(:link_login))
      end
    end

    describe "when signed in" do
      before(:each) do
        integration_log_in
        visit root_path
      end

      it "should have a logout link" do
        response.should have_selector('a', :href => logout_path, :content => I18n.t(:link_logout))
      end
    end
  end
end
