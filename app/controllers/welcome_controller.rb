class WelcomeController < ApplicationController
  def index
  	if current_user && params[:h].nil?
  		current_user.speaker=="1" ? redirect_to(speaker_url) : redirect_to(teacher_url)
  	end
  end
end
