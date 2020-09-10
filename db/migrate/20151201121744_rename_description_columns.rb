class RenameDescriptionColumns < ActiveRecord::Migration[4.2]
  def change
    rename_column :screencasts, :description, :body
    change_column :screencasts, :body, :text, null: false
    rename_column :lessons, :description, :body
    change_column :lessons, :body, :text, null: false
  end
end
