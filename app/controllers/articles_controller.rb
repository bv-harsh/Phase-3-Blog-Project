class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:show, :all]

	def index
	end

	def new
		@article = Article.new
	end

	def create
		@article = current_user.articles.new(title: params[:article][:title],
																				 body: params[:article][:body])

		if @article.save
			redirect_to users_path
		else
			render :new
		end
	end

	def show
		@article = Article.where(id: params[:id]).first
		if @article == nil
			redirect_to user_articles_path
		end
	end

	def edit
		@article = current_user.articles.where(id: params[:id]).first

		if @article
			redirect_to users_path
		end
	end

	def update
		@article = current_user.articles.where(id: params[:id]).first

		if @article &&  @article.update(user_id: params[:user_id],
																		title: params[:article][:title],
																		body: params[:article][:body])
			redirect_to user_article_path
		else
			render :edit
		end
	end

	def destroy
		@article = current_user.articles.where(id: params[:id]).first

		if @article
			@article.destroy
		end
		redirect_to users_path

	end

	def all
		@articles = Article.all
	end
end
