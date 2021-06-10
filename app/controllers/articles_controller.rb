class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:show, :all]

	def index
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(title: params[:article][:title],
													 body: params[:article][:body],
													 user_id: current_user.id)

		if @article.save
			redirect_to users_path
		else
			render :new
		end
	end

	def show
		@article = Article.where(id: params[:id]).first

		redirect_to user_articles_path if !@article
	end

	def edit
		if current_user.id == params[:user_id].to_i
			@article = Article.where(id: params[:id], user_id: params[:user_id]).first
		else
			flash[:alert] = "This article doesn't belong to you."
			redirect_to user_article_path
		end

	end

	def update
		@article = Article.where(id: params[:id], user_id: params[:user_id]).first

		if @article &&  @article.update(user_id: params[:user_id],
																		title: params[:article][:title],
																		body: params[:article][:body])
			redirect_to user_article_path
		else
			flash[:alert] = "Unable to find the article"
			redirect_to user_articles_path
		end
	end

	def destroy
		if params[:user_id].to_i == current_user.id
			@article = Article.where(id: params[:id], user_id: params[:user_id]).first
			@article.destroy if @article
			redirect_to users_path
		else
			flash[:alert] = "This article doesn't belong to you."
			redirect_to "/users/#{params[:user_id]}/articles/#{params[:id]}"
		end
	end
end
