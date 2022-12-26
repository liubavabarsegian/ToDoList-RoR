# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friend, type: :model do
  describe 'validations of presence' do
    context 'friend 1' do
      it {should validate_presence_of(:friend1).with_message(I18n.t(:cannot_be_blank))}
    end
    context 'friend 2' do
      it {should validate_presence_of(:friend2).with_message(I18n.t(:cannot_be_blank))}
    end
  end

  describe 'requests' do
    let!(:friends) do
      {friend1: 10, friend2: 15, relationship: 'request', who_sent_request: 10}
    end
    let!(:friendship) {Friend.create(friends)}
    
    context 'friend1 sends request to freidn2' do
      it 'expects relationship to equal request' do
        expect(friendship.relationship).to eq('request')
      end
      it 'expects  friend 1 be the one who sent the request' do
        expect(friendship.who_sent_request).to eq(friends[:friend1])
      end
    end

    context 'friend 2 accepts friendship' do
      it 'expects relationship to equal request' do
        expect(friendship.relationship).to eq('request')
      end
      it 'expects relationship to be frienship' do
      friendship.update_attribute(:relationship, 'friendship')
        expect(friendship.relationship).to eq('friendship')
      end
    end
  end
end
