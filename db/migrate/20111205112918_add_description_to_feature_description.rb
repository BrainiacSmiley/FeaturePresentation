class AddDescriptionToFeatureDescription < ActiveRecord::Migration
  def change
    add_column :feature_descriptions, :description, :string
  end
end
