class AddPreviewImageToLesson < ActiveRecord::Migration[4.2]
  def change
    add_column :lessons, :preview_image, :string
  end
end
