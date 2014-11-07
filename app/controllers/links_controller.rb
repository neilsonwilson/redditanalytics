class LinksController < ApplicationController

	def index
		 @link = Link.all
	    render :partial => 'index'
	end

	def create
	    @link = Link.new(task_params)
	    if @link.save
	      render 
	    else
	      render
	    end
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
