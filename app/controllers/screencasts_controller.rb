class ScreencastsController < ApplicationController
  # GET /screencasts
  def index
    @chapters = Chapter.all.order('position ASC')
  end
  
  # GET /screencasts/1
  def show
    @screencast = Screencast.friendly.find(params[:id])
  end
end