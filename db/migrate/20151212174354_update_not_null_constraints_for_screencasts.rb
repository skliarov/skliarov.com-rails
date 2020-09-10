class UpdateNotNullConstraintsForScreencasts < ActiveRecord::Migration[4.2]
  def self.up
    change_column :screencasts, :title, :string, null: false
    change_column :screencasts, :chapter_id, :integer, null: false
    change_column :screencasts, :user_id, :integer, null: false
    change_column :screencasts, :position, :integer, default: 0, null: false
  end
  
  def self.down
  end
end
