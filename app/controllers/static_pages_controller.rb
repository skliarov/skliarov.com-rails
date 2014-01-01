class StaticPagesController < ApplicationController
  before_action :set_static_page, only: [:show, :edit]

  # GET /static_pages/1
  # GET /static_pages/1.json
  def show
  end

  # GET /static_pages/1/edit
  def edit
  end

  # PATCH/PUT /static_pages/1
  # PATCH/PUT /static_pages/1.json
  def update
    respond_to do |format|
      if @static_page.update(static_page_params)
        format.html { redirect_to @static_page, notice: 'Static page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @static_page.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_static_page
      @static_page = StaticPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def static_page_params
      params.require(:static_page).permit(:title, :body)
    end
end
