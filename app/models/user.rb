require 'bcrypt'

class User < ActiveRecord::Base
  has_many :shortlinks, :inverse_of => :owner
  has_many :page_views, :through => :shortlinks
  has_many :target_urls, :through => :shortlinks

  before_validation :reset_session_token, :on => :create

  validates :username, 
    :presence => true, 
    :uniqueness => true
  validates :password_hash,
    :presence => true
  validates :session_token,
    :presence => true

  def password=(new_password)
    @password = BCrypt::Password.create(new_password) 
    self.password_hash = @password
  end

  def is_password?(unauthenticated_password)
    @password ||= BCrypt::Password.new(password_hash)
    @password.is_password?(unauthenticated_password)
  end

  def reset_session_token!
    reset_session_token
    save!
  end

  def reset_session_token
    self.session_token = SecureRandom::urlsafe_base64(16)
    session_token
  end

  def self.find_by_credentials(credentials)
    return nil if !credentials.keys.include?(:username)
    return nil if !credentials.keys.include?(:password)

    username = credentials[:username]
    password = credentials[:password]
    user = User.where(:username => username).first
    return user if !!user && user.is_password?(password)
    nil
  end
end
