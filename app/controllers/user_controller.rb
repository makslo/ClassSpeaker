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
		@user = current_user
		if @user.speaker_profile.nil?
			@profile = @user.build_speaker_profile
		else
			@profile = @user.speaker_profile
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

	def connect
		@speaker = SpeakerProfile.find(params[:id]).user
	end

	def connect_beta
		@speaker = SpeakerProfile.find(params[:id]).user
	end
	
	def book
		user_to = User.find(params[:to_id])
		user_from = User.find(params[:from_id])
		message = {
			:size=>params[:size],
			:gender=>params[:gender],
			:course=>params[:course],
			:needs=>params[:needs],
			:students=>params[:students],
			:location=>params[:location],
			:skype=>params[:skype]
		}
		UserMailer.apt_speaker(user_to,user_from,message).deliver
		UserMailer.apt_teacher(user_to,user_from,message).deliver
		b = Booking.create(count: Booking.all.size+1,email_to: user_to.email,email_from: user_from.email,date: Time.now)
		UserMailer.track(b).deliver
		redirect_to root_url
	end

	def curriculum_tch

	end

	def curriculum_sp

	end
end
