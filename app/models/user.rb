class User < ApplicationRecord
  has_many :user_parties
  has_many :parties, through: :user_parties

  validates_presence_of :password_digest
  validates_presence_of :name, :email
  validates :email, uniqueness: true
  has_secure_password
end
