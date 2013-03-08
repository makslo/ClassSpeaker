class ApplicationController < ActionController::Base
  protect_from_forgery

	def signed_in_root_path(resource)
		if current_user.uid
			speaker_url
		else
			teacher_url
		end
	end
end
