class AddColumnToRecord < ActiveRecord::Migration
  def change
    add_column :records, :card_id, :string
    add_column :records, :memo, :string
  end
end
