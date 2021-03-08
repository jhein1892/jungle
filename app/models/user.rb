class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true, length: { minimum: 3 }
  has_secure_password

  before_save {self.email.downcase!}

  def self.authenticate_with_credentials email, password_digest
      @user = User.find_by_email(email.strip.downcase)
      if @user && @user.authenticate(password_digest)
        @user
      else 
        nil 
      end 
  end
end 
