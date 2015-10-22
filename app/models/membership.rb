class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :period

  validates_uniqueness_of :user_id, scope: :period_id
end

