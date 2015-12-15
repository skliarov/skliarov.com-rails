class AddPreviewImageToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :preview_image, :string
  end
end