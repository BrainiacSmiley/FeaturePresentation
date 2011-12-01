Factory.define :feature_description do |feature_description|
  feature_description.name "New Feature Description"
end

Factory.define :feature do |feature|
  feature.name        "New feature"
  feature.example     "<p><h1>Example</h1></p>"
  feature.description "<p>New Description</p>"
  feature.association :feature_description
end

