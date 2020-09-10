class AddFriendlyIdToChapters < ActiveRecord::Migration[4.2]
  def change
    # Make titles of Chapters unique and not nullable
    change_column :chapters, :title, :string, unique: true, null: false
    # Add slug to Chapter
    add_column :chapters, :slug, :string, unique: true, null: false
    add_index :chapters, :slug, unique: true
  end
end
