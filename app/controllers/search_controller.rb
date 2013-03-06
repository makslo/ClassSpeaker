class SearchController < ApplicationController
	def career
		render json: CareerResult.terms_for(params[:term])
	end

	def location
		render json: LocationResult.terms_for(params[:term])
	end
end
