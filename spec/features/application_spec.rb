# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'tasks', type: :feature do
  scenario 'not autorized to root_path' do
    visit root_path
    expect(page).to have_text('Log in please')
  end

  scenario 'not autorized to tasks_path' do
    visit tasks_path
    expect(page).to have_text('Log in please')
  end

  scenario 'not autorized to all competitions' do
    visit all_competitions_path
    expect(page).to have_text('Log in please')
  end

  scenario 'not autorized to friends competitions' do
    visit friends_competitions_path
    expect(page).to have_text('Log in please')
  end

  #   scenario 'not autorized to friends' do
  #     visit friends_path
  #     expect(page).to have_text('Log in please')
  #   end

  #   scenario 'not autorized to my account' do
  #     visit edit_user_account
  #     expect(page).to have_text('Log in please')
  #   end

  scenario 'not autorized to friends' do
    visit 'tasks/new'
    expect(page).to have_text('Log in please')
  end
end
