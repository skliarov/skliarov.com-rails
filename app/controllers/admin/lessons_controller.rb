class Admin::LessonsController < Admin::AdminController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy, :publish, :hide]
  
  # GET /admin/lessons
  def index
    @lessons = Lesson.order('position ASC')
  end
  
  # GET /admin/lessons/1
  def show
  end
  
  # GET /admin/screencasts/1/lessons/new
  def new
    @lesson = Lesson.new
    @lesson.screencast = Screencast.friendly.find(params[:screencast_id])
  end
  
  # GET /admin/lessons/1/edit
  def edit
  end
  
  # POST /admin/lessons
  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.user = current_user
    
    if @lesson.save
      redirect_to admin_screencast_path(@lesson.screencast)
    else
      render action: 'new'
    end
  end
  
  # PATCH/PUT /admin/lessons/1
  def update
    if @lesson.update(lesson_params)
      redirect_to admin_screencast_path(@lesson.screencast)
    else
      render action: 'edit'
    end
  end
  
  # DELETE /admin/lessons/1
  def destroy
    screencast = @lesson.screencast
    @lesson.destroy
    redirect_to admin_screencast_path(screencast)
  end
  
  # POST /admin/lessons/1/publish
  def publish
    @lesson.published = true
    @lesson.save
    redirect_to admin_screencast_path(@lesson.screencast)
  end
  
  # POST /admin/lessons/1/hide
  def hide
    @lesson.published = false
    @lesson.save
    redirect_to admin_screencast_path(@lesson.screencast)
  end
  
  # POST /admin/lessons/sort
  def sort
    params[:lesson].each_with_index do |id, index|
      Lesson.where(id: id).update_all(position: index+1)
    end
    render nothing: true, status: 200, content_type: 'text/html'
  end
  
  private
    def set_lesson
      @lesson = Lesson.friendly.find(params[:id])
    end
    
    def lesson_params
      params.require(:lesson).permit(:title, :preview_image, :remove_preview_image, :slug, :body, :screencast_id)
    end
end