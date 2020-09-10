class DropChapters < ActiveRecord::Migration[4.2]
  def change
    drop_table :chapters
  end
end
