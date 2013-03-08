namespace :speaker_profile do
  desc "Generate search suggestions from products"
  task :clean => :environment do
    SpeakerProfile.remove_old
  end
end