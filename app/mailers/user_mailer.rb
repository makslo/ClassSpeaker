class UserMailer < ActionMailer::Base
  default :from => "notifications@example.com", :host=>"www.classspeaker.com"
 
  def apt_speaker(user_to,user_from,message)
  	  	@user_from = user_from
  		@user_to = user_to
  		@message = message
    mail(:to => user_to.email, :cc=>user_from.email, :from => "info@classspeaker.com", :subject => "Speaker Invitation")
  end

  def apt_teacher(user_to,user_from,message)
  		@user_from = user_from
  		@user_to = user_to
  		@message = message
  	 mail(:to => user_from.email, :cc=>user_to.email, :from => "info@classspeaker.com", :subject => "Teacher Confirmation")
  end
 # 
  def track(booking)
    @booking = booking
    mail(:to => "acohen@brainscape.com", cc: "maximlakin@gmail.com", :from => "info@classspeaker.com", :subject => "Speaker Invited!")
  end
end
