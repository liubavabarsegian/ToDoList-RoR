# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail to: @user.email, subject: 'Email confirmation'
  end

  def reminder
    @user = user
    mail to: @user.email, subject: 'Task reminder!'
  end
end
