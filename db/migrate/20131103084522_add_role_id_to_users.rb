class AddRoleIdToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :role_id, :integer, :default => 5 # id of "Associato"
    add_index :users, :role_id
  end
end
