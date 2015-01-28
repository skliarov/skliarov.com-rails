class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!, :except => [:index, :show, :feed]
  before_filter :disable_xss_protection
  load_and_authorize_resource

	# GET /articles
	# GET /articles.json
	def index
		@articles = Article.all.where.not(published_at: nil).order('published_at DESC').page(params[:page]).per(5)
	end

	def drafts
		if user_signed_in? && current_user.role.name == "Padrone"
			@articles = Article.all.where(published_at: nil).order('published_at DESC')
		else
			redirect_to root_path
		end
	end

  def feed
    @articles = Article.all.where.not(published_at: nil).order('published_at DESC').limit(10)
    render "articles/feed", layout: false
  end

	# GET /articles/1
	# GET /articles/1.json
	def show
	end

	# GET /articles/new
	def new
		@article = Article.new
	end

	# GET /articles/1/edit
	def edit
	end

	# POST /articles
	# POST /articles.json
	def create
		@article = Article.new(article_params)
		@article.user = current_user

		respond_to do |format|
			if @article.save
				# Create URL slug for article on creation
				@article.slug = nil
				@article.save

				format.html { redirect_to @article, notice: 'Article was successfully created.' }
			else
				format.html { render action: 'new' }
			end
		end
	end

	# PATCH/PUT /articles/1
	# PATCH/PUT /articles/1.json
	def update
    # Force update slug
    @article.slug = nil

		respond_to do |format|
			if @article.update(article_params)
				format.html { redirect_to @article, notice: 'Article was successfully updated.' }
			else
				format.html { render action: 'edit' }
			end
		end
	end

	# DELETE /articles/1
	# DELETE /articles/1.json
	def destroy
		@article.destroy
		respond_to do |format|
			format.html { redirect_to articles_url }
		end
	end

		private
		# Use callbacks to share common setup or constraints between actions.
		def set_article
			@article = Article.friendly.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def article_params
			params.require(:article).permit(:title, :body, :preview, :description, :keywords)
    end

    def disable_xss_protection
      response.headers['X-XSS-Protection'] = "0"
    end
end