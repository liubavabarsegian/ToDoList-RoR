# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks', type: :system do

    describe 'login' do

        scenario 'will open friends competitions' do
            user = User.create(nick: "new", email: "new@testr", password: "1234", password_confirmation: "1234", email_confirmed: true)
            visit '/login'
            fill_in 'li-email', with: user.email
            fill_in 'li-password', with: user.password
            find('#login-btn').click
            sleep(1)
            visit '/friends_competitions'
            expect(page).to have_text(I18n.t(:compete_with_all_users_button))
        end
        scenario 'will open all users competitions' do
            user = User.create(nick: "new", email: "new@testr", password: "1234", password_confirmation: "1234", email_confirmed: true)
            visit '/login'
            fill_in 'li-email', with: user.email
            fill_in 'li-password', with: user.password
            find('#login-btn').click
            sleep(1)
            visit '/all_competitions'
            expect(page).to have_text(I18n.t(:compete_with_friends_button))
        end

        # scenario 'will open friends after all users' do
        #     user = User.create(nick: "new", email: "new@testr", password: "1234", password_confirmation: "1234", email_confirmed: true)
        #     visit '/login'
        #     fill_in 'li-email', with: user.email
        #     fill_in 'li-password', with: user.password
        #     find('#login-btn').click
        #     sleep(1)
        #     visit '/all_competitions'
        #     sleep(1)
        #     find('#compete_with_friends')
        #     sleep(1)
        #     expect(page).to have_text(I18n.t(:compete_with_all_users_button))
        # end
        
    end
end