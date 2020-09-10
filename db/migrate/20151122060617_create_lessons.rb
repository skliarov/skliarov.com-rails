class CreateLessons < ActiveRecord::Migration[4.2]
  def up
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.integer :position
      t.integer :screencast_id
      t.integer :user_id
      t.boolean :published, default: false
      t.timestamps null: false
    end
    add_index :lessons, :position
    add_index :lessons, :screencast_id
    add_index :lessons, :user_id
  end
  
  def down
    remove_index :lessons, :position
    remove_index :lessons, :screencast_id
    remove_index :lessons, :user_id
    drop_table :lessons
  end
end
