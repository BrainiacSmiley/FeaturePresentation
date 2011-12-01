class AddFeatureDescriptionIdToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :feature_description_id, :integer
    add_index :features, :feature_description_id
  end
end
