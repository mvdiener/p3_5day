class User < ActiveRecord::Base
  has_many :posts
  validates :username, :password, :password_confirmation, :email, presence: :true
  validates :email, uniqueness: { case_sensitive: false }, format: {with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, message: "Invalid email format"}
  validates :password, length: { minimum: 5 }

  has_secure_password
end
