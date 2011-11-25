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

      describe "Feature List" do
        before(:each) do
          feature = Factory(:feature)
          second = Factory(:feature, :name => "Feature 2")
          third = Factory(:feature, :name => "Feature 3")

          @features = [feature, second, third]
        end

        it "should contain an entry for every feature" do
          get :home
          @features.each do |feature|
            response.should have_selector('td', :content => feature.name)
          end
        end

        describe "for non logged in user" do
          before(:each) do
            get :home
          end
          
          it "should not contain a edit link for every feature" do
            @features.each do |feature|
              response.should_not have_selector('a', :href => edit_feature_path(feature), :content => I18n.t(:link_feature_edit))
            end
          end

          it "should not contain a delete link" do
            @features.each do |feature|
              response.should_not have_selector('a', :href => feature_path(feature), :content => I18n.t(:link_feature_delete))
            end
          end

          it "should not contain a add new feature link" do
            response.should_not have_selector('a', :href => new_feature_path, :content => I18n.t(:link_feature_new))
          end
        end

        describe "for logged in user" do
          before(:each) do
            test_sign_in
            get :home
          end

          it "should contain a edit link for every feature" do
            @features.each do |feature|
              response.should have_selector('a', :href => edit_feature_path(feature), :content => I18n.t(:link_feature_edit))
            end
          end

          it "should contain a delete link" do
            @features.each do |feature|
              response.should have_selector('a', :href => feature_path(feature), :content => I18n.t(:link_feature_delete))
            end
          end

          it "should contain a add new feature link" do
            response.should have_selector('a', :href => new_feature_path, :content => I18n.t(:link_feature_new))
          end
        end
      end
    end
  end
end
