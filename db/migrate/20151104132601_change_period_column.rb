class ChangePeriodColumn < ActiveRecord::Migration
  def change
  	change_column :periods, :start_date, :date, default: '2000-01-01'
  	change_column :periods, :end_date, :date, default: '2099-12-31'
  end
end
