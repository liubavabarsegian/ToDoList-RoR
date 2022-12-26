# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users', type: :system do
    describe 'creating user' do
        scenario 'will create successfully' do
            visit new_path

            fill_in 'su-nick', with: 'tttt'
            fill_in 'su-name', with: 'test'
            fill_in 'su-email', with: 'ttt@ttt'
            fill_in 'su-password', with: '1234'
            fill_in 'su-password-conf', with: '1234'

            find("#signup-btn").click
            expect(page).to have_text('На указанную почту выслано письмо. Подтвердите почту, пожалуйста.')
        end
    end

    describe 'login' do
        user = User.create(nick: "test_userr", email: "test@testr", password: "1234", password_confirmation: "1234", email_confirmed: true)
        scenario 'will login successfully' do
            visit login_path

            fill_in 'li-email', with: user.email
            fill_in 'li-password', with: user.password
            find('#login-btn').click

            expect(page).to have_text("you have successfully logged in")

            # visit 'users/1/edit'

            # fill_in 'email', with: user.email
            # find_field('passw').set('98765')
            # find_field('passw_conf').set('98765')
            # fill_in 'number', with: '+79121231212'
            # find_field('passw_old').set(user.password)

            # find('#btn_up_user').click

            # expect(page).to have_text('Профиль обновлен')
        end
    end
    # describe 'other things' do
    #     scenario 'will open account' do
    #         user = User.create(nick: "another", email: "another@testr", password: "1234", password_confirmation: "1234", email_confirmed: true)
    #         visit '/login'
    #         fill_in 'li-email', with: user.email
    #         fill_in 'li-password', with: user.password
    #         find('#login-btn').click
    #         sleep(1)
    #         find('#nav-nick').click_link(user.nick)
    #         sleep(1)
    #         find('#nav-myacc').click_link
    #         sleep(1)
    #         expect(page).to have_text(I18n.t(:edit_account))
    #     end
    # end
end