class RemoveStaticPages < ActiveRecord::Migration
  def change
    drop_table :static_pages
  end
end
