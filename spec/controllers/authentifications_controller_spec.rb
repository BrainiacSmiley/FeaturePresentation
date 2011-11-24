require 'spec_helper'

describe AuthentificationsController do
  render_views

  describe "GET 'new'" do
    I18n.available_locales.each do |locale|
      I18n.locale = locale

      before(:each) do
        get :new
      end

      it "should be success" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_selector('title', :content => I18n.t(:title_login))
      end
    end
  end

  describe "POST 'create'" do
    describe "invalid signin" do
      before(:each) do
        @attr = {
          :name => "",
          :password => ""
        }
        post :create, :authentification => @attr
      end

      it "should render the 'new' page" do
        response.should render_template('new')
      end

      it "should have the right title" do
        response.should have_selector('title', :content => I18n.t(:title_login))
      end

      it "should have a flash.now message" do
        flash.now[:error].should == I18n.t(:login_failure)
      end
    end

    describe "valid signin" do
      before(:each) do
        @attr = {
          :name => "admin",
          :password => "test123"
        }
        post :create, :authentification => @attr
      end

      it "should log the user in" do
        controller.should be_loged_in
      end

      it "should direct to the root_page" do
        response.should redirect_to(root_path)
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "should log a user out" do
      test_sign_in
      delete :destroy, :id => 1
      controller.should_not be_loged_in
      response.should redirect_to(root_path)
    end
  end
end
