class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, omniauth_providers: [:facebook]

  has_many :memberships
  has_many :periods, through: :memberships
  has_many :user_projects
  has_many :projects, through: :user_projects

  validates_presence_of :name

  scope :accepted, -> { joins(:memberships).where.not(memberships: {user_id: nil}).group(:id) }
  scope :unaccepted, -> { joins(:memberships).where(memberships: {user_id: nil}) }
  scope :candidate, -> { order(name: :asc) }
  scope :with_last_period, -> {
    joins("INNER JOIN (SELECT * FROM memberships) AS m ON m.user_id = users.id").
    joins("LEFT OUTER JOIN (SELECT * FROM periods) AS p1 ON (m.period_id = p1.id)").
    joins("LEFT OUTER JOIN (SELECT * FROM periods) AS p2 ON
          (m.period_id = p2.id AND (p1.created_at < p2.created_at OR p1.created_at = p2.created_at AND p1.id < p2.id))").
    where('p2.id IS NULL').
    group('p1.id')
  }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || 'user@example.com'
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name || 'NO NAME'
      user.image_url = auth.info.image
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def facebook_url
    self.provider == "facebook" ? "http://facebook.com/#{self.uid}" : ""
  end

  def latest_period
    self.periods.order(end_date: :desc).first
  end
end
