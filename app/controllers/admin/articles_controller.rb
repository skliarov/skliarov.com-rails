class Admin::ArticlesController < Admin::AdminController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :publish, :hide]
  
  # GET /admin/articles
  def index
    @articles = Article.all.order('position DESC')
  end
  
  # GET /admin/articles/1
  def show
  end
  
  # GET /admin/articles/new
  def new
    @article = Article.new
  end
  
  # GET /admin/articles/1/edit
  def edit
  end
  
  # POST /admin/articles
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    
    if @article.save
      # Create URL slug for article on creation
      @article.slug = nil
      @article.save
      
      redirect_to admin_article_path(@article)
    else
      render action: 'new'
    end
  end
  
  # PATCH/PUT /admin/articles/1
  def update
    # Force update slug
    @article.slug = nil
    
    if @article.update(article_params)
      redirect_to admin_article_path(@article)
    else
      render action: 'edit'
    end
  end
  
  # DELETE /admin/articles/1
  def destroy
    @article.destroy
    redirect_to admin_articles_path
  end
  
  # POST /admin/articles/1/publish
  def publish
    @article.published = true
    @article.save
    redirect_to admin_articles_path
  end
  
  # POST /admin/articles/1/hide
  def hide
    @article.published = false
    @article.save
    redirect_to admin_articles_path
  end
  
  # POST /admin/articles/sort
  def sort
    params[:article].reverse.each_with_index do |id, index|
      Article.where(id: id).update_all(position: index+1)
    end
    render nothing: true, status: 200, content_type: 'text/html'
  end
  
  private
    def set_article
      @article = Article.friendly.find(params[:id])
    end
    
    def article_params
      params.require(:article).permit(:title, :preview, :preview_image, :remove_preview_image, :body, :description, :keywords)
    end
end