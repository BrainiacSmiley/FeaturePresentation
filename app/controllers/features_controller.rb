class FeaturesController < ApplicationController
 before_filter :authenticate, :only => [:new, :create, :edit, :update, :destroy]

  def new
    @title = t(:title_feature_new)
    @feature = current_feature_description.features.new
    @feature_descriptions = FeatureDescription.all
  end

  def create
    @feature = current_feature_description.features.create(params[:feature])
    @feature_description = current_feature_description
    if @feature.save
      flash[:success] = t(:flash_feature_created_success)
      redirect_to feature_description_path(@feature_description)
    else
      @title = t(:title_feature_new)
      @feature_descriptions = FeatureDescription.all
      render 'new'
    end
  end

  def edit
    @feature = current_feature_description.features.find_by_id(params[:id])
    @feature_description = current_feature_description
    @title = t(:title_feature_edit)
    @feature_descriptions = FeatureDescription.all
  end

  def update
    @feature = current_feature_description.features.find_by_id(params[:id])
    @feature_description = current_feature_description
    @feature_descriptions = FeatureDescription.all
    if @feature.update_attributes(params[:feature])
      @title = t(:title)
      flash[:success] = t(:flash_feature_edited_success)
      redirect_to feature_description_path(@feature_description)
    else
      @title = t(:title_feature_edit)
      render 'edit'
    end
  end

  def destroy
    feature_to_destroy = current_feature_description.features.find_by_id(params[:id])
    @feature_description = current_feature_description
    @feature_descriptions = FeatureDescription.all
    @title = t(:title)
    feature_to_destroy.destroy
    flash[:success] = t(:flash_feature_deleted_success)
    redirect_to feature_description_path(@feature_description)
  end
end
