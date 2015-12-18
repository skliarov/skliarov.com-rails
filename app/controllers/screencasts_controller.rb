class ScreencastsController < ApplicationController
  def index
    @chapters = Chapter.all.order('position ASC')
  end
  
  def show
    @screencast = Screencast.friendly.find(params[:id])
  end
end