# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before(:each) do
    assign(:users, [
             User.create!(
               nick: 'Nick',
               name: 'Name',
               surname: 'Surname',
               email: 'Email',
               password: 'Password'
             ),
             User.create!(
               nick: 'Nick',
               name: 'Name',
               surname: 'Surname',
               email: 'Email',
               password: 'Password'
             )
           ])
  end

  it 'renders a list of users' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Nick'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Surname'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Email'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Password'.to_s), count: 2
  end
end
