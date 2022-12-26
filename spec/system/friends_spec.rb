# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks', type: :system do
  describe 'tasks' do
    scenario 'will open friends page' do
      user = User.create(nick: 'new', email: 'new@testr', password: '1234', password_confirmation: '1234',
                         email_confirmed: true)
      visit '/login'
      fill_in 'li-email', with: user.email
      fill_in 'li-password', with: user.password
      find('#login-btn').click
      sleep(1)
      visit '/friends'
      expect(page).to have_text(I18n.t(:find_new_friends))
    end
    scenario 'will open friends page' do
      user = User.create(nick: 'new', email: 'new@testr', password: '1234', password_confirmation: '1234',
                         email_confirmed: true)
      visit '/login'
      fill_in 'li-email', with: user.email
      fill_in 'li-password', with: user.password
      find('#login-btn').click
      sleep(1)
      visit '/users'
      expect(page).to have_text(I18n.t(:users))
    end
  end
end
