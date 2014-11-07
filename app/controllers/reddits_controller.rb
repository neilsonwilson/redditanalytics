class RedditsController < ApplicationController

	def index
		@link = Link.new
	end

	def create
	end

	def scrap	
	end

	def show
		common = ['person', '1', '2', 'i','love']

		@comments = []
		link = params[:link] + ".json"
		@response = HTTParty.get(URI.encode(link))
	    @result = JSON.parse(@response.body)
	    @result[1]["data"]["children"].each do |comment|
	    	@comments.push({:content => comment["data"]["body"] , :children => []})
	    end
	    words = {}
	    @comments.each do |comment|
	    	next unless comment[:content] != nil
	    	comment[:content].strip.downcase.split(/[^\w']+/).group_by(&:to_s).map{ |w| 
	    		words[w[0]] = w[1].count unless common.include? w[0]
	    	} 
	    end
		render json: words.to_json
	end


end
