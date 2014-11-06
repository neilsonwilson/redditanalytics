class RedditsController < ApplicationController
	
	def index
		@link = Link.new
	end

	def create
	end

	def scrap	
	end

	def show
	link = params[:link] + ".json"
	@response = HTTParty.get(URI.encode(link))
    @result = JSON.parse(@response.body)
    render json: @result
	end

end
