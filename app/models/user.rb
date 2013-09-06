class User < ActiveRecord::Base
  has_many :surveys
  validates :email, uniqueness: true
  
  include BCrypt

  def password
    @password ||= Password.new(password_digest)  
  end

  def password=(pass)
    @entered_password = pass
    @password =Password.create(pass)
    self.password_digest = @password
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && (user.password == password)
    nil
  end
end
