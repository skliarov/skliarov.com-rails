class LessonsController < ApplicationController
  # GET /screencasts/1/lessons/2
  def show
    @lesson = Lesson.friendly.find(params[:id])
  end
end