class User < ApplicationRecord

  before_create :set_default_role
  has_many :reviews
  has_many :places, :through => :reviews
  belongs_to :place, optional: true
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy

  ROLES = [:admin, :moderator, :user, :owner, :banned]
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
    
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def roles= (roles)
    self.roles_mask = (roles & ROLES).map { |r| 2** ROLES.index(r) }.sum
  end
  
  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2** ROLES.index(r)).zero? }
  end
  
  def role_strings
    roles.map(& :to_s )
  end
  
  def is?(role)
    roles.include?(role)
  end
  
  private
  def set_default_role
    self.roles = [:user]
  end

end
