# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'calendars', type: :system do
  describe 'calendars' do
    scenario 'will open month page' do
      user = User.create(nick: 'another', email: 'another@testr', password: '1234',
                         password_confirmation: '1234', email_confirmed: true)
      visit '/login'
      fill_in 'li-email', with: user.email
      fill_in 'li-password', with: user.password
      find('#login-btn').click
      sleep(1)
      visit '/month'
      expect(page).to have_text(I18n.t(:month_calendar))
    end
    scenario 'will open week page' do
      user = User.create(nick: 'another', email: 'another@testr', password: '1234',
                         password_confirmation: '1234', email_confirmed: true)
      visit '/login'
      fill_in 'li-email', with: user.email
      fill_in 'li-password', with: user.password
      find('#login-btn').click
      sleep(1)
      visit '/week'
      expect(page).to have_text(I18n.t(:week_calendar))
    end
    scenario 'will open week page' do
      user = User.create(nick: 'another', email: 'another@testr', password: '1234',
                         password_confirmation: '1234', email_confirmed: true)
      visit '/login'
      fill_in 'li-email', with: user.email
      fill_in 'li-password', with: user.password
      find('#login-btn').click
      sleep(1)
      visit '/month'
      find('#month-calendar').click
      sleep(1)
      expect(page).to have_text(I18n.t(:week_calendar))
    end
  end
end
