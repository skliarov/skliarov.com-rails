class AddSlugColumnToArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :slug, :string, unique: true
    add_index :articles, :slug, unique: true
  end
end
