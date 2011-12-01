namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    5.times do |n|
      name = "Feature Kategorie #{n+1}"
      FeatureDescription.create!(:name => name)
    end
    10.times do |n|
      name = "Feature #{n+1}"
      example = "<h1>#{Faker::Lorem.sentence}</h1><h2>#{Faker::Lorem.sentence}</h2><h3>#{Faker::Lorem.sentence}</h3><h4>#{Faker::Lorem.sentence}</h4>"
      description = Faker::Lorem.sentences(5)
      FeatureDescription.all.each do |fd|
        fd.features.create!(:name => name,
                        :example => example,
                        :description => description
        )
      end
    end
  end
end
