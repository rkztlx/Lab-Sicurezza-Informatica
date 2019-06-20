class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, cid: auth.uid).first_or_create do |client|
      client.email = auth.info.email
      client.password = Devise.friendly_token[0,20]
    end
  end
          
  def self.new_with_session(params, session)
    super.tap do |client|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        client.email = data["email"] if client.email.blank?
      end
    end
  end

end
