# frozen_string_literal: true

# user
class User < ApplicationRecord
  has_secure_password

  validates_uniqueness_of :nick, message: I18n.t(:already_exists)
  validates_uniqueness_of :email, message: I18n.t(:already_exists)

  validates_presence_of :nick, message: I18n.t(:cannot_be_blank)
  validates_presence_of :email, message: I18n.t(:cannot_be_blank), format: {with: URI::MailTo::EMAIL_REGEXP}
  validates_presence_of :password, message: I18n.t(:cannot_be_blank)
  validates_presence_of :password_confirmation, message: I18n.t(:cannot_be_blank)

  before_create :confirmation_token

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  # rubocop:disable Naming/PredicateName
  def is_friend?(user)
    !Friend.where(friend1: id,
                  friend2: user.id).or(Friend.where(friend1: user.id,
                                                    friend2: id)).where(relationship: 'friendship').empty?
  end
  # rubocop:enable Naming/PredicateName

  private

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end
end
