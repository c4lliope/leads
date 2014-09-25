class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:linkedin]

  validates :name, presence: true
  validates :token, presence: true

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.image = auth.info.image
      user.location = { name: auth.info.location.name, country: auth.info.location.country.code }
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.token = auth.credentials.token
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.linkedin_data"] && session["devise.linkedin_data"]["credentials"]["token"]
        user.token = data["credentials"]["token"]
      end
    end
  end
end
