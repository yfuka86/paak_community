class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :period_id
      t.string :url
      t.text :summary

      t.timestamps null: false
    end
  end
end
