class Suggestions
	def initialize(app)
		@app = app
	end

	def call(env)
		if env["PATH_INFO"] == "/career-search/results"
			request = Rack::Request.new(env)
			terms = CareerResult.terms_for(request.params["term"])
			["200",{"Content-Type" => "application/json"},[terms.to_json]]
		elsif env["PATH_INFO"] == "/location-search/results"
			request = Rack::Request.new(env)
			terms = LocationResult.terms_for(request.params["term"])
			["200",{"Content-Type" => "application/json"},[terms.to_json]]
		else
			@app.call(env)
		end
	end
end