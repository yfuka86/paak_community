class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :number
      t.integer :code
      t.string :explanation

      t.timestamps null: false
    end
  end
end
