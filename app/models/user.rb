class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates_uniqueness_of :nick, message: 'already exists'
  validates_uniqueness_of :email, message: 'already exists'

  validates :email, presence: true
  validates :nick, presence: true
  validates :password_digest, presence: true
end
