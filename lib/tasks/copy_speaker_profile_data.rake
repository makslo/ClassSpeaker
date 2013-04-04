namespace :speaker_profile do
  desc "Copy data to from profile to user model"
  task :copy => :environment do
    User.copy_speaker_data
  end
end