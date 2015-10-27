class AddColumnToMembership < ActiveRecord::Migration
  def change
    add_column :memberships, :memo, :string
  end
end
