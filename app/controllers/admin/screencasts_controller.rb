class Admin::ScreencastsController < Admin::AdminController
  before_action :set_screencast, only: [:show, :edit, :update, :destroy, :publish, :hide]
  
  # GET /admin/screencasts
  def index
    @screencasts = Screencast.order('position ASC')
  end
  
  # GET /admin/screencasts/1
  def show
  end
  
  # GET /admin/chapter/1/screencasts/new
  def new
    @screencast = Screencast.new
    @screencast.chapter = Chapter.friendly.find(params[:chapter_id])
  end
  
  # GET /admin/screencasts/1/edit
  def edit
  end
  
  # POST /admin/screencasts
  def create
    @screencast = Screencast.new(screencast_params)
    @screencast.user = current_user
    
    if @screencast.save
      redirect_to admin_chapter_path(@screencast.chapter)
    else
      render action: 'new'
    end
  end
  
  # PATCH/PUT /admin/screencasts/1
  def update
    if @screencast.update(screencast_params)
      redirect_to admin_chapter_path(@screencast.chapter)
    else
      render action: 'edit'
    end
  end
  
  # DELETE /admin/screencasts/1
  def destroy
    chapter = @screencast.chapter
    @screencast.destroy
    redirect_to admin_chapter_path(chapter)
  end
  
  # POST /admin/screencasts/1/publish
  def publish
    @screencast.published = true
    @screencast.save
    redirect_to admin_chapter_path(@screencast.chapter)
  end
  
  # POST /admin/screencasts/1/hide
  def hide
    @screencast.published = false
    @screencast.save
    redirect_to admin_chapter_path(@screencast.chapter)
  end
  
  # POST /admin/screencasts/sort
  def sort
    params[:screencast].each_with_index do |id, index|
      Screencast.where(id: id).update_all(position: index+1)
    end
    render nothing: true, status: 200, content_type: 'text/html'
  end
  
  private
    def set_screencast
      @screencast = Screencast.friendly.find(params[:id])
    end
    
    def screencast_params
      params.require(:screencast).permit(:title, :preview_image, :remove_preview_image, :slug, :body, :chapter_id)
    end
end