class RemoveStaticPages < ActiveRecord::Migration[4.2]
  def change
    drop_table :static_pages
  end
end
