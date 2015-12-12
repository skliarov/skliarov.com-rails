class UpdateNotNullConstraintsForChapters < ActiveRecord::Migration
  def self.up
    change_column :chapters, :user_id, :integer, null: false
    change_column :chapters, :position, :integer, default: 0, null: false
  end
  
  def self.down
  end
end