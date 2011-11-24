require 'spec_helper'

describe FeaturesController do
  render_views

  I18n.available_locales.each do |locale|
    I18n.locale = locale

    describe "GET 'new'" do
      before(:each) do
        get :new
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right title"do
        response.should have_selector('title', :content => I18n.t(:title_feature_new))
      end

      it "should have a name field" do
        response.should have_selector('input', :name => 'feature[name]', :type => 'text')
      end

      it "should have a example text area" do
        response.should have_selector('textarea', :name => 'feature[example]')
      end

      it "should have a description text area" do
        response.should have_selector('textarea', :name => 'feature[description]')
      end
    end

    describe "POST 'create'" do
      describe "failure" do
        before(:each) do
          @attr = {
            :name        => "",
            :example     => "",
            :description => ""
          }
        end

        it "should not create a new feature" do
          lambda do
            post :create, :feature => @attr
          end.should_not change(Feature, :count)
        end

        it "should have the right title" do
          post :create, :feature => @attr
          response.should have_selector('title', :content => I18n.t(:title_feature_new))
        end

        it "should render the 'new' page" do
          post :create, :feature => @attr
          response.should render_template('new')
        end
      end

      describe "success" do
        before(:each) do
          @attr = {
            :name        => "New Feature",
            :example     => "<html><h1>New Example</h1></html>",
            :description => "New Description"
          }
        end

        it "should create a new feature" do
          lambda do
            post :create, :feature => @attr
          end.should change(Feature, :count).by(1)
        end

        it "should redirect to the root_page" do
          post :create, :feature => @attr
          response.should redirect_to(root_path)
        end

        it "should have a flash[:success] message" do
          post :create, :feature => @attr
          flash[:success].should == I18n.t(:flash_feature_created_success)
        end
      end
    end

    describe "GET 'edit'" do
      before(:each) do
        @feature = Factory(:feature)
        get :edit, :id => @feature
      end

      it "should be successful" do
        response.should be_success
      end

      it "should have the right title" do
        response.should have_selector('title', :content => I18n.t(:title_feature_edit))
      end
    end

    describe "PUT 'update'" do
      before(:each) do
        @feature = Factory(:feature)
      end

      describe "failure" do
        before(:each) do
          @attr = {
            :name => "",
            :example => "",
            :description => ""
          }
          put :update, :id => @feature, :feature => @attr
        end

        it "should render the edit page" do
          response.should render_template('edit')
        end

        it "should have the right title" do
          response.should have_selector('title', :content => I18n.t(:title_feature_edit))
        end
      end

      describe "success" do

      end
    end
  end
end
