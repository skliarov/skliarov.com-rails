class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :publish]
  before_filter :authenticate_user!, :except => [:index, :show, :feed]
  before_filter :disable_xss_protection
  load_and_authorize_resource
  
  # GET /articles
  def index
    @articles = Article.all.where.not(published_at: nil).order('published_at DESC').page(params[:page]).per(5)
  end
  
  def drafts
    if user_signed_in? && current_user.role.name == "Padrone"
      @articles = Article.all.where(published_at: nil).order('created_at DESC')
    else
      redirect_to root_path
    end
  end
  
  def feed
    @articles = Article.all.where.not(published_at: nil).order('published_at DESC').limit(10)
    render "articles/feed", layout: false
  end
  
  # GET /articles/1
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
        
        format.html { redirect_to drafts_path, notice: 'Article was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end
  
  # POST "/articles/1/publish"
  def publish
    if @article.published_at
      redirect_to root_path
      return
    end
    
    @article.published_at = DateTime.current
    respond_to do |format|
      if @article.save
        format.html { redirect_to root_path, notice: 'Article was successfully published.' }
      else
        format.html { render action: 'edit' }
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
    if @article.published_at
      # Deleted published article
      @article.destroy
      respond_to do |format|
        format.html { redirect_to articles_url }
      end
    else
      # Deleted article from drafts
      @article.destroy
      respond_to do |format|
        format.html { redirect_to drafts_path }
      end
    end
  end
  
  private
  def set_article
    @article = Article.friendly.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :body, :preview, :description, :keywords)
  end
  
  def disable_xss_protection
    response.headers['X-XSS-Protection'] = "0"
  end
end