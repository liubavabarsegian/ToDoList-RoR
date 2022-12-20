# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates_uniqueness_of :nick, message: 'already exists'
  validates_uniqueness_of :email, message: 'already exists'

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :nick, presence: true
  validates :password_digest, presence: true
  validates :password_confirmation, presence: true # if new?

  before_create :confirmation_token


  private

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end
end
