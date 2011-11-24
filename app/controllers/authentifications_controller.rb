class AuthentificationsController < ApplicationController
  def new
    @title = t(:title_login)
  end

  def create
    login_needed = "admin"
    password_needed = "test123"

    if (params[:authentification][:login] != login_needed && params[:authentification][:password] != password_needed)
      flash.now[:error] = t(:login_failure)
      @title = t(:title_login)
      render 'new'
    else
      log_in
      redirect_to root_path
    end
  end
  
  def destroy
    log_out
    redirect_to root_path
  end
end