class CreateChapters < ActiveRecord::Migration
  def up
    create_table :chapters do |t|
      t.string :title
      t.integer :position
      t.integer :user_id
      t.boolean :published, default: false
      t.timestamps null: false
    end
    add_index :chapters, :position
    add_index :chapters, :user_id
  end
  
  def down
    remove_index :chapters, :position
    remove_index :chapters, :user_id
    drop_table :chapters
  end
end