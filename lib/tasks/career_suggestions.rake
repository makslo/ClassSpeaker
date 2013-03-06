namespace :career_suggestions do
  desc "Generate search suggestions from products"
  task :index => :environment do
    CareerResult.index_careers
  end
end