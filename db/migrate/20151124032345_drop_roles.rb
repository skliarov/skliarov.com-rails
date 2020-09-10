class DropRoles < ActiveRecord::Migration[4.2]
  def change
    drop_table :roles
  end
end
