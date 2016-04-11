class DropScreencasts < ActiveRecord::Migration
  def change
    drop_table :screencasts
  end
end