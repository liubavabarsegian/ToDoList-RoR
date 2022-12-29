# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe UserMailer, type: :mailer do
#   describe 'confirmation' do
#     let!(:user_info) do
#       { nick: 'qqqqnew', email: 'hhh@hhh', password: '1234', password_confirmation: '1234' }
#     end
#     let!(:user) { User.create!(user_info) }

#     let!(:mail) { UserMailer.registration_confirmation(user) }

#     it 'checks email subject' do
#       expect(mail.subject).to eq('Email confirmation')
#     end

#     it "checks user's email" do
#       expect(mail.to).to eq([user[:email]])
#     end

#     it "check's senders email" do
#       expect(mail.from).to eq([ENV['TODO_APP_GMAIL']])
#     end
#     it "check's emailbody" do
#       expect(mail.body.encoded).not_to be_empty
#     end
#   end
# end
