class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def linkedin
		render :text=> request.env["omniauth.auth"].to_yaml
		
	end

	def tmp
		user = User.from_omniauth(request.env["omniauth.auth"])
		if user.persisted?
	      flash.notice = "Signed in!"
	      sign_in_and_redirect user
	    else
	      session["devise.user_attributes"] = user.attributes
	      redirect_to new_user_registration_url
	    end
	end
end

