class DropScreencasts < ActiveRecord::Migration[4.2]
  def change
    drop_table :screencasts
  end
end
