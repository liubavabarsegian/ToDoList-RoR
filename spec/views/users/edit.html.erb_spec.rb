# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/edit', type: :view do
  let(:user) do
    User.create!(
      nick: 'MyString',
      name: 'MyString',
      surname: 'MyString',
      email: 'MyString',
      password: 'MyString'
    )
  end

  before(:each) do
    assign(:user, user)
  end

  it 'renders the edit user form' do
    render

    assert_select 'form[action=?][method=?]', user_path(user), 'post' do
      assert_select 'input[name=?]', 'user[nick]'

      assert_select 'input[name=?]', 'user[name]'

      assert_select 'input[name=?]', 'user[surname]'

      assert_select 'input[name=?]', 'user[email]'

      assert_select 'input[name=?]', 'user[password]'
    end
  end
end
