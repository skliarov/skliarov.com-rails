class DropChapters < ActiveRecord::Migration
  def change
    drop_table :chapters
  end
end