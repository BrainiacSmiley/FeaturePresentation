require 'spec_helper'

describe FeatureDescriptionsController do
  render_views

  I18n.available_locales.each do |locale|
    I18n.locale = locale

    describe "GET 'new'" do
      describe "as non loged in" do
        before(:each) do
          get :new
        end

        it "should redirect to login" do
          response.should redirect_to '/login'
        end
      end

      describe "as loged in" do
        before(:each) do
          test_sign_in
          get :new
        end

        it "should be successful" do
          response.should be_success
        end

        it "should have the right title" do
          response.should have_selector('title', :content => I18n.t(:title_feature_description_new))
        end

        it "should have a name field" do
          response.should have_selector('input', :name => 'feature_description[name]', :type => 'text')
        end
      end
    end

    describe "POST 'create'" do
      describe "as non loged in" do
        before(:each) do
          @attr = {
            :name => ""
          }
          post :create, :feature_description => @attr
        end

        it "should redirect to login" do
          response.should redirect_to '/login'
        end
      end

      describe "as loged in" do
        before(:each) do
          test_sign_in
        end

        describe "failure" do
          before(:each) do
            @attr = {
              :name => ""
            }
          end

          it "should not create a new feature description" do
            lambda do
              post :create, :feature_description => @attr
            end.should_not change(FeatureDescription, :count)
          end

          it "should have the right title" do
            post :create, :feature_description => @attr
            response.should have_selector('title', :content => I18n.t(:title_feature_description_new))
          end

          it "should render the 'new' page" do
            post :create, :feature_description => @attr
            response.should render_template('new')
          end
        end

        describe "success" do
          before(:each) do
            @attr = {
              :name => "New FeatureDescription"
            }
          end

          it "should create a new feature description" do
            lambda do
              post :create, :feature_description => @attr
            end.should change(FeatureDescription, :count).by(1)
          end

          it "should redirect to the root_page" do
            post :create, :feature_description => @attr
            response.should redirect_to(root_path)
          end

          it "should have a flash[:success] message" do
            post :create, :feature_description => @attr
            flash[:success].should == I18n.t(:flash_feature_description_created_success)
          end
        end
      end
    end

    describe "GET 'edit'" do
      describe "as non loged in" do
        it "should redirect to login" do
          get :edit, :id => Factory(:feature_description)
          response.should redirect_to '/login'
        end
      end

      describe "as loged in" do
        before(:each) do
          @feature_description = Factory(:feature_description)
          test_sign_in
          get :edit, :id => @feature_description
        end

        it "should be successful" do
          response.should be_success
        end

        it "should have the right title" do
          response.should have_selector('title', :content => I18n.t(:title_feature_description_edit))
        end
      end
    end

    describe "PUT 'update'" do
      before(:each) do
        @feature_description = Factory(:feature_description)
      end

      describe "as non loged in" do
        before(:each) do
          @attr = {
            :name => ""
          }
          put :update, :id => @feature_description, :feature_description => @attr
        end

        it "should redirect to login" do
          response.should redirect_to '/login'
        end
      end

      describe "as loged in" do
        before(:each) do
          test_sign_in
        end

        describe "failure" do
          before(:each) do
            @attr = {
              :name => ""
            }
            put :update, :id => @feature_description, :feature_description => @attr
          end

          it "should render the edit page" do
            response.should render_template('edit')
          end

          it "should have the right title" do
            response.should have_selector('title', :content => I18n.t(:title_feature_description_edit))
          end
        end

        describe "success" do
          before(:each) do
            @attr = {
              :name => "Changed Feature Description Name"
            }
            put :update, :id => @feature_description, :feature_description => @attr
          end

          it "should change the features attributes" do
            @feature_description.reload
            @feature_description.name.should == @attr[:name]
          end

          it "should redirect to the feature show page" do
            response.should redirect_to feature_description_path(@feature_description)
          end

          it "should have a flash[:success] message" do
            flash[:success].should == I18n.t(:flash_feature_description_edited_success)
          end
        end
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) do
        @feature_description = Factory(:feature_description)
      end

      describe "as non loged in" do
        before(:each) do
          delete :destroy, :id => @feature_description
        end

        it "should redirect to login" do
          response.should redirect_to '/login'
        end
      end

      describe "as loged in" do
        before(:each) do
          test_sign_in
        end

        it "should delte the feature" do
          lambda do
            delete :destroy, :id => @feature_description
          end.should change(FeatureDescription, :count).by(-1)
        end

        it "should redirect to home" do
          delete :destroy, :id => @feature_description
          response.should redirect_to root_path
        end
      end
    end

    describe "GET 'show" do
      before(:each) do
        @feature_description = Factory(:feature_description)
        @feature1 = Factory(
          :feature,
          :feature_description => @feature_description,
          :name => "Feature 1"
        )
        @feature2 = Factory(
          :feature,
          :feature_description => @feature_description,
          :name => "Feature 2"
        )
        @features = [@feature1, @feature2]
      end

      describe "as non loged in" do
        before(:each) do
          get :show, :id => @feature_description
        end

        it "should be success" do
          response.should be_success
        end

        it "should have the right title" do
          response.should have_selector('a', :content => @feature_description.name)
        end

        it "should not have a new link" do
          response.should_not have_selector('a', :href => new_feature_path, :content => I18n.t(:link_feaure_new))
        end

        describe "feature list" do
          it "should contain every element of the feature list" do
            @features.each do |feature|
              response.should have_selector('h1', :content => feature.name)
            end
          end

          it "should not contain a edit link for every element of the feature list" do
            @features.each do |feature|
              response.should_not have_selector('a', :href => edit_feature_path(feature), :content => I18n.t(:link_feature_edit))
            end
          end

          it "should not contain a delete link for every element of the feature list" do
            @features.each do |feature|
              response.should_not have_selector('a', :href => feature_path(feature), :content => I18n.t(:link_feature_delete))
            end
          end
        end
      end

      describe "as loged in" do
        before(:each) do
          test_sign_in
          get :show, :id => @feature_description
        end

        it "should have a new link" do
          response.should have_selector('a', :href => new_feature_path, :content => I18n.t(:link_feature_new))
        end

        describe "feature list" do
          it "should contain a edit link for every element of the feature list" do
            @features.each do |feature|
              response.should have_selector('a', :href => edit_feature_path(feature), :content => I18n.t(:link_feature_edit))
            end
          end

          it "should contain a delete link for every element of the feature list" do
            @features.each do |feature|
              response.should have_selector('a', :href => feature_path(feature), :content => I18n.t(:link_feature_delete))
            end
          end
        end
      end
    end
  end
end
