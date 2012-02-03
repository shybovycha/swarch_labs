require 'digest/md5'

class User < ActiveRecord::Base
	validates :email, 
		:length => { :minimum => 3, :maximum => 255 },
		:uniqueness => true,
		:presence => true,
		:email => true,
		:on => :create

	validates :name, 
		:uniqueness => true,
		:presence => true,
		:length => { :minimum => 3, :maximum => 255 },
		:on => :create

	validates :password,
		:length => { :minimum => 6, :maximum => 255 },
		:on => :create,
		:presence => true,
		:confirmation => true

	before_save :encode_password

private
  def encode_password
    self.password = Digest::MD5.hexdigest(password)
  end

public
  def self.authenticate(email, password)
    return false if email.nil? or password.nil? 
    return false if email.empty? or password.empty?

    u = User.find_by_email(email)

    return false if u.nil?
    return false if Digest::MD5.hexdigest(password) != u.password
    return u 
  end
end
