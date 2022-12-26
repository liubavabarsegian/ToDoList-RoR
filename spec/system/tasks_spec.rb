# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks', type: :system do
  describe 'login' do
    scenario 'will see new task button' do
      user = User.create(nick: 'new', email: 'new@testr', password: '1234', password_confirmation: '1234',
                         email_confirmed: true)
      visit '/login'
      fill_in 'li-email', with: user.email
      fill_in 'li-password', with: user.password
      find('#login-btn').click
      expect(page).to have_text(I18n.t(:new_task))
    end
    scenario 'will see no tasks' do
      user = User.create(nick: 'new', email: 'new@testr', password: '1234', password_confirmation: '1234',
                         email_confirmed: true)
      visit '/login'
      fill_in 'li-email', with: user.email
      fill_in 'li-password', with: user.password
      find('#login-btn').click
      expect(page).to have_text(I18n.t(:all_tasks_are_completed))
    end
    scenario 'will click on new task button' do
      user = User.create(nick: 'new', email: 'new@testr', password: '1234', password_confirmation: '1234',
                         email_confirmed: true)
      visit '/login'
      fill_in 'li-email', with: user.email
      fill_in 'li-password', with: user.password
      find('#login-btn').click
      find('#btn-add').click
      expect(page).to have_text(I18n.t(:due))
    end
    # scenario 'will click on new task button' do
    #     user = User.create(nick: "new", email: "new@testr", password: "1234", password_confirmation: "1234", email_confirmed: true)
    #     visit '/login'
    #     fill_in 'li-email', with: user.email
    #     fill_in 'li-password', with: user.password
    #     find('#login-btn').click
    #     find('#btn-add').click
    #     expect(page).to have_text(I18n.t(:due))
    # end
  end
end
