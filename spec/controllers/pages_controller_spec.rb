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

      describe "Feature Description List" do
        before(:each) do
          feature = Factory(:feature_description)
          second = Factory(:feature_description, :name => "Feature Description 2")
          third = Factory(:feature_description, :name => "Feature Description 3")

          @feature_descriptions = [feature, second, third]
          get :home
        end

        it "should contain an entry for every feature description" do
          @feature_descriptions.each do |feature_description|
            response.should have_selector(
              'a',
              :content => feature_description.name
            )
          end
        end

        it "should contain a link to the feature description show page for every entry" do
          @feature_descriptions.each do |feature_description|
            response.should have_selector(
              'a',
              :href => feature_description_path(feature_description)
            )
          end
        end

        describe "for non logged in user" do
          before(:each) do
            get :home
          end
          
          it "should not contain a add new feature link" do
            response.should_not have_selector(
              'a',
              :href => new_feature_description_path,
              :content => I18n.t(:link_feature_description_new)
            )
          end
        end

        describe "for logged in user" do
          before(:each) do
            test_sign_in
            get :home
          end

          it "should contain a add new feature link" do
            response.should have_selector(
              'a',
              :href => new_feature_description_path,
              :content => I18n.t(:link_feature_description_new)
            )
          end
        end
      end
    end
  end
end
