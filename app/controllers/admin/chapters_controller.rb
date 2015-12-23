class Admin::ChaptersController < Admin::AdminController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy, :publish, :hide]
  
  # GET /admin/chapters
  def index
    @chapters = Chapter.order('position ASC')
  end
  
  # GET /admin/chapters/new
  def new
    @chapter = Chapter.new
  end
  
  # GET /admin/chapters/1/edit
  def edit
  end
  
  # POST /admin/chapters
  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.user = current_user
    
    if @chapter.save
      redirect_to admin_chapters_path
    else
      render action: 'new'
    end
  end
  
  # PATCH/PUT /admin/chapters/1
  def update
    if @chapter.update(chapter_params)
      redirect_to admin_chapters_path
    else
      render action: 'edit'
    end
  end
  
  # DELETE /admin/chapters/1
  def destroy
    @chapter.destroy
    redirect_to admin_chapters_path
  end
  
  # POST /admin/chapters/1/publish
  def publish
    @chapter.published = true
    @chapter.save
    redirect_to admin_chapters_path
  end
  
  # POST /admin/chapters/1/hide
  def hide
    @chapter.published = false
    @chapter.save
    redirect_to admin_chapters_path
  end
  
  # POST /admin/chapters/sort
  def sort
    params[:chapter].each_with_index do |id, index|
      Chapter.where(id: id).update_all(position: index+1)
    end
    render nothing: true, status: 200, content_type: 'text/html'
  end
  
  private
    def set_chapter
      @chapter = Chapter.friendly.find(params[:id])
    end
    
    def chapter_params
      params.require(:chapter).permit(:title, :slug)
    end
end