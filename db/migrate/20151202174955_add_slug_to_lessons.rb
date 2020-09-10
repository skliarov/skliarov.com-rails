class AddSlugToLessons < ActiveRecord::Migration[4.2]
  def change
    add_column :lessons, :slug, :string, unique: true, null: false
    add_index :lessons, :slug, unique: true
  end
end
