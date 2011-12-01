class AuthentificationsController < ApplicationController
  def new
    @title = t(:title_login)
    @feature_descriptions = FeatureDescription.all
  end

  def create
    login_needed = "admin"
    password_needed = "test123"

    if (params[:authentification][:login] != login_needed && params[:authentification][:password] != password_needed)
      flash.now[:error] = t(:login_failure)
      @title = t(:title_login)
      @feature_descriptions = FeatureDescription.all
      render 'new'
    else
      sign_in
      redirect_to root_path
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end