class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.datetime :timestamp
      t.integer :membership_id
      t.integer :code

      t.timestamps null: false
    end
    add_index :records, :membership_id
  end
end
