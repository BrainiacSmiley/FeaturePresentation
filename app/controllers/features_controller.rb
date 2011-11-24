class FeaturesController < ApplicationController
  def new
    @title = t(:title_feature_new)
    @feature = Feature.new
  end

  def create
    @feature = Feature.new(params[:feature])
    if @feature.save
      flash[:success] = t(:flash_feature_created_success)
      redirect_to root_path
    else
      @title = t(:title_feature_new)
      render 'new'
    end
  end

  def edit
    @feature = Feature.find_by_id(params[:id])
    @title = t(:title_feature_edit)
  end

  def update
    @feature = Feature.find_by_id(params[:id])
    if @feature.update_attributes(params[:feature])
    else
      @title = t(:title_feature_edit)
      render 'edit'
    end
  end
end
