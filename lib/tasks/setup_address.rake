namespace :user_address do
  desc "Copy data to from profile to user model"
  task :set => :environment do
    User.set_user_address
  end
end