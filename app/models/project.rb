class Project < ActiveRecord::Base
  has_many :user_projects
  has_many :users, through: :user_projects
  belongs_to :period

  accepts_nested_attributes_for :user_projects, allow_destroy: true, reject_if: proc { |attributes| attributes['user_id'].blank? }

  validates :name, presence: true
  validates :period_id, presence: true
  validates_presence_of :user_projects
end
