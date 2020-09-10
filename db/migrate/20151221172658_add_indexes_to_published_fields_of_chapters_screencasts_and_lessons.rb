class AddIndexesToPublishedFieldsOfChaptersScreencastsAndLessons < ActiveRecord::Migration[4.2]
  def up
    add_index :chapters, :published
    add_index :screencasts, :published
    add_index :lessons, :published
  end
  
  def down
    remove_index :chapters, :published
    remove_index :screencasts, :published
    remove_index :lessons, :published
  end
end
