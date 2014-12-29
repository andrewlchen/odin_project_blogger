class ArticlesController < ApplicationController
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
		@article.save 

		flash.notice = "New post created: '#{@article.title}'"

		redirect_to article_path(@article)
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
			params.require(:article).permit(:title, :body, :tag_list)
		end 
end
