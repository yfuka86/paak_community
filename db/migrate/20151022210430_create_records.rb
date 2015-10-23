class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.datetime :timestamp
      t.integer :member_id
      t.integer :code

      t.timestamps null: false
    end
    add_index :records, :member_id
  end
end
