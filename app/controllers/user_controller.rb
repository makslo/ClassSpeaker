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
		@speakers = SpeakerProfile.find_speakers(params).paginate(:page => params[:page], :per_page => 5)
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
			flash[:success]="You're in!"
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
	def book
		user_to = User.find(params[:to_id])
		user_from = User.find(params[:from_id])
		message = {:subject=>params[:subject],:students=>params[:students],:body=>params[:body]}
		UserMailer.apt_speaker(user_to,user_from,message).deliver
		UserMailer.apt_teacher(user_to,user_from,message).deliver
		redirect_to root_url
	end

	def curriculum_tch

	end

	def curriculum_sp

	end
end
