class FriendsController < ApplicationController
  
  def index
    redirect_to login_path unless user_signed_in?

    @requests = Friend.all.where(friend_id: current_user.id, sent_request: true)
    @friends = Friend.all.where(user_id: current_user.id, friendship: true) + Friend.all.where(friend_id: current_user.id, friendship: true)
  end

  def send_request
    @requests = Friend.all.where(friend_id: current_user.id, sent_request: true)
    puts "aloha"
    @user = User.find(friend_params[:user_id])
    puts @user.id
    @friend = User.find(friend_params[:friend_id])
    puts @friend.id
    if Friend.exists?(user_id: @user.id, friend_id: @friend.id) 
      @possible_friend = Friend.find_by(user_id: @user.id, friend_id: @friend.id)
    elsif Friend.exists?(friend_id: @user.id, user_id: @friend.id)
      @possible_friend = Friend.find_by(friend_id: @user.id, user_id: @friend.id)
    else
      @possible_friend = Friend.create(friend_params)
    end
    puts @possible_friend.id
    if @possible_friend.valid?
      @possible_friend.update_attribute(:sent_request, true)
      @possible_friend.update_attribute(:incoming_request, false)
      @possible_friend.update_attribute(:friendship, false)
    else
        #message about error
    end
  end

  def cancell_request
    @requests = Friend.all.where(friend_id: current_user.id, sent_request: true)
    puts "cancell"
    @user = User.find(friend_params[:user_id])
    puts @user.id
    @friend = User.find(friend_params[:friend_id])
    puts @friend.id
    if Friend.exists?(user_id: @user.id, friend_id: @friend.id) 
      @pff_goodbye = Friend.find_by(user_id: @user.id, friend_id: @friend.id)
      puts @pff_goodbye.id
      @pff_goodbye.delete
    elsif Friend.exists?(friend_id: @user.id, user_id: @friend.id)
      @pff_goodbye = Friend.find_by(friend_id: @user.id, user_id: @friend.id)
      puts @pff_goodbye
      @pff_goodbye.delete
    end
    # @pff_goodbye.update_attribute(:sent_request, false)
    # @pff_goodbye.update_attribute(:incoming_request, false)
    # @pff_goodbye.update_attribute(:friendship, false)
  end

  def get_request
  end

  def accept_request
    @requests = Friend.all.where(friend_id: current_user.id, sent_request: true)
    @friend = Friend.where(friend_params)[0]

    @friend.update_attribute(:sent_request, false)
    @friend.update_attribute(:incoming_request, false)
    @friend.update_attribute(:friendship, true)
  end

  def decline_request
    @friend = Friend.where(friend_params)[0]
    @requests = Friend.all.where(friend_id: current_user.id, sent_request: true)
    @loser = Friend.find_by(friend_params)
    @loser.delete
  end

  def destroy_friendship
    puts "cancell"
    @user = User.find(friend_params[:user_id])
    puts @user.id
    @friend = User.find(friend_params[:friend_id])
    
    if Friend.exists?(user_id: @user.id, friend_id: @friend.id) 
      @loser = Friend.find_by(user_id: @user.id, friend_id: @friend.id)
      puts @loser.id
      @loser.delete
    elsif Friend.exists?(friend_id: @user.id, user_id: @friend.id)
      @loser = Friend.find_by(friend_id: @user.id, user_id: @friend.id)
      puts @loser
      @loser.delete
    end
  end

  private
  def friend_params
    params.permit(:friend_id, :user_id)
  end
end
