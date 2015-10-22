class Period < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :projects

  enum code: [:project, :community, :academy, :others]
end
