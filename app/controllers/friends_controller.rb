# frozen_string_literal: true

# friends
class FriendsController < ApplicationController
  include FriendsHelper

  def index
    redirect_to login_path unless user_signed_in?

    @requests = requests
    @friends = friends
  end

  # rubocop:disable Metrics/AbcSize
  def send_request

    @requests = requests
    @friend1 = User.find(friend_params[:friend1])
    @friend2 = User.find(friend_params[:friend2])
    @user = User.find(second_user(@friend1, @friend2).id)
    @possible_friend = Friend.create!(friend_params)
    retrun unless @possible_friend.valid?

    @possible_friend.update_attribute(:relationship, 'request')
    @possible_friend.update_attribute(:who_sent_request, @friend1.id)
  end
  # rubocop:enable Metrics/AbcSize

  def cancell_request
    @requests = requests
    @friend1 = User.find(friend_params[:friend1])
    @friend2 = User.find(friend_params[:friend2])
    @user = User.find(second_user(@friend1, @friend2).id)
    @request = find_request(@friend1, @friend2)

    @request.delete
  end

  def accept_request
    @requests = requests
    @friend1 = User.find(friend_params[:friend1])
    @friend2 = User.find(friend_params[:friend2])
    @user = User.find(second_user(@friend1, @friend2).id)
    @request = find_request(@friend2, @friend1)

    @request.update_attribute(:relationship, 'friendship')
    @friendship = @request
  end

  def decline_request
    @requests = requests
    @friend1 = User.find(friend_params[:friend1])
    @friend2 = User.find(friend_params[:friend2])
    @user = User.find(second_user(@friend1, @friend2).id)
    @loser = find_request(@friend2, @friend1)

    @loser.delete
  end

  def destroy_friendship
    @requests = requests
    @friend1 = User.find(friend_params[:friend1])
    @friend2 = User.find(friend_params[:friend2])
    @user = User.find(second_user(@friend1, @friend2).id)
    @loser = find_friend(@friend2)
    @loser.delete
  end

  private

  def friend_params
    params.permit(:friend1, :friend2)
  end
end
