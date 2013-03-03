class UserController < ApplicationController
	def profile
		u = current_user
		@profile = u.speaker_profile
	end

	def update
		s = current_user.speaker_profile
		s.update_attributes(params[:speaker_profile])
		redirect_to speaker_url

	end

	def teacher
		if params[:career]
			@speakers = SpeakerProfile.find_speakers(params[:career],params[:location],params[:school])
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
		if p.save
		redirect_to speaker_url
		else
			@profile = p
			render 'speaker'
		end
	end
	def search
		
	end
	def appointment
		@speaker = SpeakerProfile.find(params[:id]).user
	end
end
