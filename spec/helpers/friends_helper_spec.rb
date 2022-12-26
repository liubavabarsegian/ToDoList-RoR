# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the FriendsHelper. For example:
#
# describe FriendsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe FriendsHelper, type: :helper do
  describe 'requests' do
    context 'check request' do
        let!(:friend1) {User.create({nick: "qwe", email: "asd@asd", password: "qwe", password_confirmation: "qwe"})}
        let!(:friend2) {User.create({nick: "asd", email: "qwe@asd", password: "qwe", password_confirmation: "qwe"})}
        let!(:request){Friend.create({friend1: friend1.id, friend2: friend2.id, relationship: 'request', who_sent_request: friend1.id})}
        it 'friend1 must be valid' do
            expect(friend1.valid?).to eq(true)
        end
        it 'friend2 must be valid' do
            expect(friend2.valid?).to eq(true)
        end
        it 'request must be valid' do
            expect(request.valid?).to eq(true)
        end
    end

    context 'when requests are sent' do
        let!(:friend1) {User.create({nick: "qwe", email: "asd@asd", password: "qwe", password_confirmation: "qwe"})}
        let!(:friend2) {User.create({nick: "asd", email: "qwe@asd", password: "qwe", password_confirmation: "qwe"})}
        let!(:request){Friend.create({friend1: friend1.id, friend2: friend2.id, relationship: 'request', who_sent_request: friend1.id})}
        it 'must find the request' do
            request = find_request(friend1, friend2)
            expect(request.relationship).to eq('request')
        end
        it 'must write who sent request' do
            request = find_request(friend1, friend2)
            expect(request.who_sent_request).to eq(friend1.id)
        end
        it 'must write second friend' do
            request = find_request(friend1, friend2)
            expect(request.friend2).to eq(friend2.id)
        end
    end

    context 'make friendship' do
    let!(:current_user) {User.create({nick: "qwe", email: "asd@asd", password: "qwe", password_confirmation: "qwe"})}
    let!(:friend2) {User.create({nick: "asd", email: "qwe@asd", password: "qwe", password_confirmation: "qwe"})}
    let!(:request){Friend.create({friend1: current_user.id, friend2: friend2.id, relationship: 'request', who_sent_request: current_user.id})}
        it 'will change request to friendship' do
            request = find_request(current_user, friend2)
            request.update_attribute(:relationship, 'friendship')
            expect(request.relationship).to eq('friendship')
        end
        it 'finds friendship' do
            request = find_request(current_user, friend2)
            request.update_attribute(:relationship, 'friendship')
            request = find_friend(friend2)
            expect(request.relationship).to eq('friendship')
        end
        it 'finds friend id' do
            request = find_request(current_user, friend2)
            request.update_attribute(:relationship, 'friendship')
            request = find_friend(friend2)
            expect(request.friend2).to eq(friend2.id)
        end
    end
  end
end
