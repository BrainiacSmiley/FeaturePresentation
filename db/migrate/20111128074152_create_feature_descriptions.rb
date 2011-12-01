class CreateFeatureDescriptions < ActiveRecord::Migration
  def change
    create_table :feature_descriptions do |t|
      t.string :name

      t.timestamps
    end
  end
end
