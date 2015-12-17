class AddPreviewImageToLesson < ActiveRecord::Migration
  def change
    add_column :lessons, :preview_image, :string
  end
end