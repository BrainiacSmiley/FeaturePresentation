class FeatureDescriptionsController < ApplicationController
  before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]

  def show
    set_current_feature_description(params[:id])
    @feature_description = current_feature_description
    @title = @feature_description.name
    @feature_descriptions = FeatureDescription.all
    @features = @feature_description.features
  end

  def new
    @title = t(:title_feature_description_new)
    @feature_descriptions = FeatureDescription.all
    @feature_description = FeatureDescription.new
  end

  def create
    @feature_description = FeatureDescription.new(params[:feature_description])

    if @feature_description.save
      @title = t(:title)
      flash[:success] = t(:flash_feature_description_created_success)
      redirect_to root_path
    else
      @title = t(:title_feature_description_new)
      @feature_descriptions = FeatureDescription.all
      render 'new'
    end
  end

  def edit
    @title = t(:title_feature_description_edit)
    @feature_description = FeatureDescription.find_by_id(params[:id])
    @feature_descriptions = FeatureDescription.all
  end

  def update
    @feature_description = FeatureDescription.find_by_id(params[:id])
    @feature_descriptions = FeatureDescription.all

    if @feature_description.update_attributes(params[:feature_description])
      @title = t(:title)
      flash[:success] = t(:flash_feature_description_edited_success)
      redirect_to feature_description_path(@feature_description)
    else
      @title = t(:title_feature_description_edit)
      render 'edit'
    end
  end

  def destroy
    @feature_descriptions = FeatureDescription.all
    @title = t(:title)
    feature_description_to_destroy = FeatureDescription.find_by_id(params[:id])
    feature_description_to_destroy.destroy
    flash[:success] = t(:flash_feature_description_deleted_success)
    redirect_to root_path
  end
end
