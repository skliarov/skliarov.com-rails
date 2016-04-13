class ArticlesController < ApplicationController
  # GET /articles
  def index
    @articles = Article.where(published: true).order('position DESC').page(params[:page]).per(5)
  end
  
  # GET /articles/1
  def show
    @article = Article.find_by(slug: params[:slug])
  end
  
  # GET /feed
  def feed
    @articles = Article.where(published: true).order('position DESC').limit(10)
    render 'articles/feed', layout: false
  end
end