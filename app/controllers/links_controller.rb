class LinksController < ApplicationController

	# def index
	# 	 @link = Link.all
	    
	# end

	def index
		common = ['person', '1', '2', 'i','love']
		if params[:link] == nil
			return render json: {:error=>'a'}
		end
		@comments = []
		link = params[:link].to_s + ".json"
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
	    @sorted = words.sort_by {|_key, value| value}.reverse
	    # render json: @sorted
	    render :partial => 'index'
	end
	def create
	end

	def update
	end

	def show
	end

	def destroy
	end

 private
    def task_params
      params.require(:link).permit(:url, :issubreddit, :keyword, :created_at, :updated_at)
 end

end
