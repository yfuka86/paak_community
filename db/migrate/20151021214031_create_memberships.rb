class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :paak_id
      t.integer :user_id
      t.integer :period_id
      t.string :name

      t.timestamps null: false
    end
  end
end
