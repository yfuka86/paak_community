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

  scope :accepted, -> { includes(:memberships).where.not(memberships: {user_id: nil}).group(:id) }
  scope :unaccepted, -> { includes(:memberships).where(memberships: {user_id: nil}) }
  scope :candidate, -> { order(name: :asc) }
  scope :order_by_last_period, -> {
    joins(:periods).having('periods.end_date = MAX(periods.end_date)').group('periods.id').order('periods.end_date DESC, periods.id DESC')
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
