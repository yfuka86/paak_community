class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, omniauth_providers: [:facebook]

  has_many :memberships

  scope :accepted, -> { joins('LEFT OUTER JOIN memberships ON memberships.user_id = users.id').where.not(memberships: {user_id: nil}).group(:id) }
  scope :unaccepted, -> { joins('LEFT OUTER JOIN memberships ON memberships.user_id = users.id').where(memberships: {user_id: nil}) }


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
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
end
