class ArticlesController < ApplicationController
  
  # GET /articles
  def index
    @articles = Article.all.where.not(published_at: nil).order('published_at DESC').page(params[:page]).per(5)
  end
  
  # GET /feed
  def feed
    @articles = Article.all.where.not(published_at: nil).order('published_at DESC').limit(10)
    render 'articles/feed', layout: false
  end
  
  # GET /articles/1
  def show
    @article = Article.friendly.find(params[:id])
  end
  
  private
    def article_params
      params.require(:article).permit(:title, :preview, :body, :description, :keywords)
    end
end