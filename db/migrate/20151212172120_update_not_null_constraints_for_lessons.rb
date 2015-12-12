class UpdateNotNullConstraintsForLessons < ActiveRecord::Migration
  def self.up
    change_column :lessons, :title, :string, null: false
    change_column :lessons, :screencast_id, :integer, null: false
    change_column :lessons, :user_id, :integer, null: false
    change_column :lessons, :position, :integer, default: 0, null: false
  end
  
  def self.down
  end
end