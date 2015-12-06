class Admin::ScreencastsController < Admin::AdminController
  before_action :set_screencast, only: [:show, :edit, :update, :destroy]
  
  # GET /admin/screencasts
  def index
    @screencasts = Screencast.order('position ASC')
  end
  
  # GET /admin/screencasts/1
  def show
  end
  
  # GET /admin/screencasts/new
  def new
    @screencast = Screencast.new
  end
  
  # GET /admin/screencasts/1/edit
  def edit
  end
  
  # POST /admin/screencasts
  def create
    @screencast = Screencast.new(screencast_params)
    @screencast.user = current_user
    
    if @screencast.save
      redirect_to admin_screencast_path(@screencast)
    else
      render action: 'new'
    end
  end
  
  # PATCH/PUT /admin/screencasts/1
  def update
    if @screencast.update(screencast_params)
      redirect_to admin_screencast_path(@screencast)
    else
      render action: 'edit'
    end
  end
  
  # DELETE /admin/screencasts/1
  def destroy
    @screencast.destroy
    redirect_to admin_screencasts_path
  end
  
  def sort_lessons
    params[:lesson].each_with_index do |id, index|
      lesson = Lesson.find(id)
      unless lesson.nil?
        lesson.position = index + 1
        lesson.save
      end
    end
    render nothing: true, status: 200, content_type: 'text/html'
  end
  
  private
    def set_screencast
      @screencast = Screencast.friendly.find(params[:id])
    end
    
    def screencast_params
      params.require(:screencast).permit(:title, :slug, :body, :chapter_id)
    end
end