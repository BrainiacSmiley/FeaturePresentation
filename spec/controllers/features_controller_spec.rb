require 'spec_helper'

describe FeaturesController do
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
          @feature_description = Factory(:feature_description)
          test_set_current_feature_description(@feature_description.id)
          get :new
        end

        it "should be successful" do
          response.should be_success
        end

        it "should have the right title" do
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
    end

    describe "POST 'create'" do
      describe "as non loged in" do
        before(:each) do
          @attr = {
            :name        => "",
            :example     => "",
            :description => ""
          }
          post :create, :feature => @attr
        end

        it "should redirect to login" do
          response.should redirect_to '/login'
        end
      end

      describe "as loged in" do
        before(:each) do
          test_sign_in
          @feature_description = Factory(:feature_description)
          test_set_current_feature_description(@feature_description.id)
        end
        
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

          it "should redirect to the show page" do
            post :create, :feature => @attr
            response.should redirect_to feature_description_path(@feature_description)
          end

          it "should have a flash[:success] message" do
            post :create, :feature => @attr
            flash[:success].should == I18n.t(:flash_feature_created_success)
          end
        end
      end
    end

    describe "GET 'edit'" do
      describe "as non loged in" do
        it "should redirect to login" do
          get :edit, :id => Factory(:feature)
          response.should redirect_to '/login'
        end
      end

      describe "as loged in" do
        before(:each) do
          test_sign_in
          @feature_description = Factory(:feature_description)
          @feature = Factory(:feature, :feature_description => @feature_description)
          test_set_current_feature_description(@feature_description.id)
          get :edit, :id => @feature
        end

        it "should be successful" do
          response.should be_success
        end

        it "should have the right title" do
          response.should have_selector('title', :content => I18n.t(:title_feature_edit))
        end
      end
    end

    describe "PUT 'update'" do
      before(:each) do
        @feature_description = Factory(:feature_description)
        @feature = Factory(:feature, :feature_description => @feature_description)
        test_set_current_feature_description(@feature_description.id)
      end

      describe "as non loged in" do
        before(:each) do
          @attr = {
            :name => "",
            :example => "",
            :description => ""
          }
          put :update, :id => @feature, :feature => @attr
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
          before(:each) do
            @attr = {
              :name => "Changed Name",
              :example => "<html><h2>Example</h2></html>",
              :description => "Changed Description"
            }
            put :update, :id => @feature, :feature => @attr
          end

          it "should change the features attributes" do
            @feature.reload
            @feature.name.should == @attr[:name]
            @feature.example.should == @attr[:example]
            @feature.description.should == @attr[:description]
          end

          it "should redirect to the feature_description show page" do
            response.should redirect_to feature_description_path(@feature_description)
          end

          it "should have a flash[:success] message" do
            flash[:success].should == I18n.t(:flash_feature_edited_success)
          end
        end
      end
    end

    describe "DELETE 'destroy'" do
      before(:each) do
        @feature_description = Factory(:feature_description)
        @feature = Factory(:feature, :feature_description => @feature_description)
        test_set_current_feature_description(@feature_description.id)
      end
      
      describe "as non loged in" do
        before(:each) do
          delete :destroy, :id => @feature
        end

        it "should redirect to login" do
          response.should redirect_to '/login'
        end
      end

      describe "as loged in" do
        before(:each) do
          test_sign_in
        end

        it "should delete the feature" do
          lambda do
            delete :destroy, :id => @feature
          end.should change(Feature, :count).by(-1)
        end

        it "should redirect to feature_description show page" do
          delete :destroy, :id => @feature
          response.should redirect_to feature_description_path(@feature_description)
        end
      end
    end
  end
end
