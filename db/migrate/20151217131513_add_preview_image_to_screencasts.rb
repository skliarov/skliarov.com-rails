class AddPreviewImageToScreencasts < ActiveRecord::Migration[4.2]
  def change
    add_column :screencasts, :preview_image, :string
  end
end
