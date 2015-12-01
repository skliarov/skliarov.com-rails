class RenameDescriptionColumns < ActiveRecord::Migration
  def change
    rename_column :screencasts, :description, :body
    change_column :screencasts, :body, :text, null: false
    rename_column :lessons, :description, :body
    change_column :lessons, :body, :text, null: false
  end
end