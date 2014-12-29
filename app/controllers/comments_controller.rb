class CommentsController < ApplicationController
	respond_to :html, :xml, :json

	def create 
		@comment = Comment.new(comment_params)
		@comment.article_id = params[:article_id]

		if @comment.valid? 
			@comment.save 
			redirect_to article_path(@comment.article)
		else 
			redirect_to article_path(@comment.article)
		end 
	end 

	private 
		def comment_params 
			params.require(:comment).permit(:commenter, :comment)
		end 
end
