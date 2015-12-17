class AddPreviewImageToScreencasts < ActiveRecord::Migration
  def change
    add_column :screencasts, :preview_image, :string
  end
end