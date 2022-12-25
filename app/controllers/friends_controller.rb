class FriendsController < ApplicationController
  include FriendsHelper

  def index
    redirect_to login_path unless user_signed_in?

    @requests = requests
    @friends = friends
  end

  def send_request
    @requests = requests
    @friend_1 = User.find(friend_params[:friend_1])
    @friend_2 = User.find(friend_params[:friend_2])
    @user = User.find(second_user(@friend_1, @friend_2).id)
    @possible_friend = Friend.create!(friend_params)
    if @possible_friend.valid?
      @possible_friend.update_attribute(:relationship, 'request')
      @possible_friend.update_attribute(:who_sent_request, @friend_1.id)
    else
        #message about error
    end
  end

  def cancell_request
    @requests = requests
    @friend_1 = User.find(friend_params[:friend_1])
    @friend_2 = User.find(friend_params[:friend_2])
    @user = User.find(second_user(@friend_1, @friend_2).id)
    @request = find_request(@friend_1, @friend_2)

    @request.delete
  end



  def accept_request
    @requests = requests
    @friend_1 = User.find(friend_params[:friend_1])
    @friend_2 = User.find(friend_params[:friend_2])
    @user = User.find(second_user(@friend_1, @friend_2).id)
    @request = find_request(@friend_2, @friend_1)

    @request.update_attribute(:relationship, 'friendship')
    @friendship = @request
  end

  def decline_request
    @requests = requests
    @friend_1 = User.find(friend_params[:friend_1])
    @friend_2 = User.find(friend_params[:friend_2])
    @user = User.find(second_user(@friend_1, @friend_2).id)
    @loser = find_request(@friend_2, @friend_1)

    @loser.delete
  end

  def destroy_friendship
    @requests = requests
    @friend_1 = User.find(friend_params[:friend_1])
    @friend_2 = User.find(friend_params[:friend_2])
    @user = User.find(second_user(@friend_1, @friend_2).id)
    @loser = find_friend(@friend_2)
    @loser.delete
  end

  private
  def friend_params
    params.permit(:friend_1, :friend_2)
  end
end
