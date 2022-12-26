# frozen_string_literal: true

# application mailer
class ApplicationMailer < ActionMailer::Base
  default from: ENV['TODO_APP_GMAIL']
  layout 'mailer'
end
