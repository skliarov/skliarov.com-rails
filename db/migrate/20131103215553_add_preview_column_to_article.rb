class AddPreviewColumnToArticle < ActiveRecord::Migration[4.2]
  def change
  	add_column :articles, :preview, :text
  end
end
