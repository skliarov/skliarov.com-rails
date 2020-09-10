class CreateScreencasts < ActiveRecord::Migration[4.2]
  def up
    create_table :screencasts do |t|
      t.string :title
      t.text :description
      t.integer :position
      t.integer :chapter_id
      t.integer :user_id
      t.boolean :published, default: false
      t.timestamps null: false
    end
    add_index :screencasts, :position
    add_index :screencasts, :user_id
    add_index :screencasts, :chapter_id
  end
  
  def down
    remove_index :screencasts, :position
    remove_index :screencasts, :user_id
    remove_index :screencasts, :chapter_id
    drop_table :screencasts
  end
end
