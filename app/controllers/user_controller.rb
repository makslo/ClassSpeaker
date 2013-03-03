class UserController < ApplicationController
	def profile
		@user = current_user
	end

	def teacher
		if params[:career]
			@speakers = SpeakerProfile.find_speakers(params[:career])
		end
	end

	def speaker
		u = current_user
		if u.speaker_profile.nil?
			@profile = u.build_speaker_profile
		else
			@profile = u.speaker_profile
		end
	end

	def create_profile
		u = current_user
		p = u.build_speaker_profile(params[:speaker_profile])
		p.save
		redirect_to speaker_url
	end
	def search
		
	end
	def appointment
		@speaker = SpeakerProfile.find(params[:id]).user
	end
end
