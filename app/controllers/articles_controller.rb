class ArticlesController < ApplicationController
	respond_to :html, :xml, :json

	def index 
		@articles = Article.all 
	end

	def show 
		@article = Article.find(params[:id])
		@comment = Comment.new 
		@comment.article_id = @article.id
	end  

	def new 
		@article = Article.new 
	end 

	def create 
		@article = Article.new(article_params)
		saved = @article.save 
		
		if saved
			flash.notice = "New post created: '#{@article.title}'"
		end 

		respond_with(@article)
	end 

	def destroy 
		@article = Article.find(params[:id])
		@article.destroy 

		flash.notice = "Post '#{@article.title}' was deleted."

		redirect_to articles_path
	end 

	def edit 
		@article = Article.find(params[:id])
	end 

	def update 
		@article = Article.find(params[:id])
		@article.update(article_params) 

		flash.notice = "Post '#{@article.title}' was updated."

		redirect_to article_path(@article)
	end 

	private 
		def article_params
			params.require(:article).permit(:title, :body, :tag_list, :image)
		end 
end
