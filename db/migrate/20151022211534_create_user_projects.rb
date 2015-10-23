class CreateUserProjects < ActiveRecord::Migration
  def change
    create_table :user_projects do |t|
      t.integer :user_id, null: false
      t.integer :project_id, null: false

      t.timestamps null: false
    end
    add_index :user_projects, [:project_id, :user_id], unique: true, using: :btree
  end
end
