class FeaturesController < ApplicationController
 before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]

  def new
    @title = t(:title_feature_new)
    @feature = Feature.new
    @features = Feature.all
  end

  def create
    @feature = Feature.new(params[:feature])
    if @feature.save
      flash[:success] = t(:flash_feature_created_success)
      redirect_to root_path
    else
      @title = t(:title_feature_new)
      @features = Feature.all
      render 'new'
    end
  end

  def edit
    @feature = Feature.find_by_id(params[:id])
    @title = t(:title_feature_edit)
    @features = Feature.all
  end

  def update
    @feature = Feature.find_by_id(params[:id])
    @features = Feature.all
    if @feature.update_attributes(params[:feature])
      @title = t(:title)
      flash[:success] = t(:flash_feature_edited_success)
      redirect_to root_path
    else
      @title = t(:title_feature_edit)
      render 'edit'
    end
  end

  def destroy
    @features = Feature.all
    @title = t(:title)
    feature_to_destroy = Feature.find_by_id(params[:id])
    feature_to_destroy.destroy
    flash[:success] = t(:flash_feature_deleted_success)
    redirect_to root_path
  end

  private
    def authenticate
      deny_access unless signed_in?
    end

    def deny_access
      redirect_to login_path, :notice => t(:please_sin_in)
    end
end
