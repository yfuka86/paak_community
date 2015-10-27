class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :period

  has_many :records

  validates :period_id, presence: true
  validates :user_id, uniqueness: {scope: :period_id}
  validates :paak_id, uniqueness: {scope: :period_id}, if: :paak_id

  scope :by_period_code, -> (code) { joins(:period).where(periods: {code: Period.codes[code.to_sym]})}
  scope :current_in_paak, -> {
    Time.zone = 'Tokyo'
    today = Time.now.to_date
    tomorrow = today + 1.day
    joins("LEFT OUTER JOIN (SELECT * FROM records WHERE records.timestamp BETWEEN '#{today}' AND '#{tomorrow}') AS r1 ON (memberships.id = r1.membership_id)").
    joins("LEFT OUTER JOIN (SELECT * FROM records WHERE records.timestamp BETWEEN '#{today}' AND '#{tomorrow}') AS r2 ON
          (memberships.id = r2.membership_id AND (r1.created_at < r2.created_at OR r1.created_at = r2.created_at AND r1.id < r2.id))").
    where('r2.id IS NULL').
    where('r1.code = ?', Record.codes["enter"])
  }
  scope :has_user, -> {
    joins(:user).where.not(users: {id: nil})
  }
end

