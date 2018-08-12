class User
  include Mongoid::Document
  field :email, type: String
  field :password_digest, type: String

  include ActiveModel::SecurePassword
  has_secure_password

  validates :email, presence: true
end