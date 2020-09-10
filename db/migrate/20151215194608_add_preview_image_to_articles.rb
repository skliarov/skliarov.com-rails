class AddPreviewImageToArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :preview_image, :string
  end
end
