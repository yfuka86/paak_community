class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :paak_id
      t.integer :user_id
      t.integer :period_id, null: false
      t.string :name

      t.timestamps null: false
    end
    add_index :memberships, [:period_id, :user_id], unique: true, using: :btree
    add_index :memberships, [:period_id, :paak_id], unique: true, using: :btree
  end
end
