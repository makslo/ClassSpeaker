namespace :location_suggestions do
  desc "Generate search suggestions from products"
  task :index => :environment do
    LocationResult.index_locations
  end
end