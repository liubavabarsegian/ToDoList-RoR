class FriendsController < ApplicationController
  
  def index
    redirect_to login_path unless user_signed_in?

    @requests = Friend.all.where(friend_id: current_user.id, sent_request: true)
    @friends = Friend.all.where(user_id: current_user.id, friendship: true)
  end

  def send_request

    @possible_friend = Friend.create(friend_params)
    if @possible_friend.valid?
      @possible_friend.update_attribute(:sent_request, true)
      @possible_friend.update_attribute(:incoming_request, false)
      @possible_friend.update_attribute(:friendship, false)
    else
      #message about error
    end
  end

  def cancell_request
    @pff_goodbye = Friend.where(friend_params)[0]
    @pff_goodbye.update_attribute(:sent_request, false)
    @pff_goodbye.update_attribute(:incoming_request, false)
    @pff_goodbye.update_attribute(:friendship, false)
  end

  def get_request
  end

  def accept_request
    @friend = Friend.where(friend_params)[0]
    @pff_goodbye.update_attribute(:sent_request, false)
    @pff_goodbye.update_attribute(:incoming_request, false)
    @pff_goodbye.update_attribute(:friendship, true)
  end

  def decline_request
  end

  def destroy_friendship
  end

  private
  def friend_params
    params.permit(:friend_id, :user_id)
  end
end
