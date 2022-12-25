# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  # has_many: :friends

  validates_uniqueness_of :nick, message: 'already exists'
  validates_uniqueness_of :email, message: 'already exists'

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :nick, presence: true
  validates :password_digest, presence: true
  validates :password_confirmation, presence: true # if new?

  before_create :confirmation_token

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  def is_friend?(user)
    !Friend.where(friend_1: self.id, friend_2: user.id).or(Friend.where(friend_1:  user.id, friend_2: self.id)).where(relationship: 'friendship').empty?
  end
  
  private

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end
  

end
