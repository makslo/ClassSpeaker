class UserMailer < ActionMailer::Base
  default :from => "notifications@example.com"
 
  def apt_speaker(user_to,user_from,message)
    mail(:to => user_to.email, :cc=>user_from.email, :from => "info@classspeaker.com", :subject => "speaker")
  end

  def apt_teacher(user_to,user_from,message)
  	 mail(:to => user_from.email, :cc=>user_to.email, :from => "info@classspeaker.com", :subject => "teacher")
  end
end
