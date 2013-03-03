ActionMailer::Base.smtp_settings = {
  :address              => "oxmail.registrar-servers.com",
  :port                 => 26,
  :domain               => "classspeaker.com",
  :user_name            => "info@classspeaker.com",
  :password             => "speakr123",
  :authentication       => "plain",
  :enable_starttls_auto => true
}