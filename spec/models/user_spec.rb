# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations of presence' do
    context 'nick' do
      it { should validate_presence_of(:nick).with_message(I18n.t(:cannot_be_blank)) }
    end

    context 'email' do
      it { should validate_presence_of(:nick).with_message(I18n.t(:cannot_be_blank)) }
    end

    context 'password' do
      it { should validate_presence_of(:password).with_message(I18n.t(:cannot_be_blank)) }
    end

    context 'password confirmation' do
      it { should validate_presence_of(:password_confirmation).with_message(I18n.t(:cannot_be_blank)) }
    end
  end

  describe 'validations of uniquenes' do
    let!(:unique) do
      { nick: 'aaa', email: 'test@aaa', password: '1234', password_confirmation: '1234' }
    end
    let!(:nick_repeated) do
      { nick: 'aaa', email: 'test2@test', password: '1234', password_confirmation: '1234' }
    end
    let!(:email_repeated) do
      { nick: 'test2', email: 'test@aaa', password: '1234', password_confirmation: '1234' }
    end
    let!(:first_user) { User.create(unique) }
    let!(:second_user) { User.new(nick_repeated) }
    let!(:third_user) { User.new(email_repeated) }

    it 'creates first user' do
      expect(first_user.valid?).to eq(true)
    end
    it 'does not create second user' do
      expect(second_user.valid?).to eq(false)
    end
    it 'does not create third user' do
      expect(third_user.valid?).to eq(false)
    end
  end

  describe 'validations of correctness' do
    let!(:user_with_wrong_email) { User.create(email: 'wrongemail') }
    it 'does not create this user' do
      expect(user_with_wrong_email.valid?).to eq(false)
    end
  end
end
