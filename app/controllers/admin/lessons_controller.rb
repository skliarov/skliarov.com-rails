class Admin::LessonsController < Admin::AdminController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  
  # GET /admin/lessons
  def index
    @lessons = Lesson.order('position ASC')
  end
  
  # GET /admin/lessons/1
  def show
  end
  
  # GET /admin/lessons/new
  def new
    @lesson = Lesson.new
  end
  
  # GET /admin/lessons/1/edit
  def edit
  end
  
  # POST /admin/lessons
  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.user = current_user
    
    if @lesson.save
      redirect_to admin_lesson_path(@lesson)
    else
      render action: 'new'
    end
  end
  
  # PATCH/PUT /admin/lessons/1
  def update
    if @lesson.update(lesson_params)
      redirect_to admin_lesson_path(@lesson)
    else
      render action: 'edit'
    end
  end
  
  # DELETE /admin/lessons/1
  def destroy
    @lesson.destroy
    redirect_to admin_lessons_path
  end
  
  private
    def set_lesson
      @lesson = Lesson.friendly.find(params[:id])
    end
    
    def lesson_params
      params.require(:lesson).permit(:title, :slug, :body, :screencast_id)
    end
end