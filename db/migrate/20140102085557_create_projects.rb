class CreateProjects < ActiveRecord::Migration[4.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
