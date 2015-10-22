class Project < ActiveRecord::Base
  has_many :user_projects
  has_many :users, through: :user_projects
  belongs_to :period

  validates :name, presence: true
  validates :period_id, presence: true
end
