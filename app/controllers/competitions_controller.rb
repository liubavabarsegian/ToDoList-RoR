class CompetitionsController < ApplicationController
  def friend?(user)
    !Friend.all.where(friendship:true, friend_id: current_user.id).select{|friend| friend.user_id == user}.empty? || !Friend.all.where(friendship: true, user_id: current_user.id).select{|friend| friend.friend_id == user}.empty?
  end

  def friends
    redirect_to login_path unless user_signed_in?
    if user_signed_in?
      puts "ddd"
      @completed_tasks = Task.where(completed: true).select{|task| friend?(task.user_id)}.group_by(&:user_id)
      # @friends = Friend.all.where(user_id: current_user.id, friendship: true) + Friend.all.where(friend_id: current_user.id, friendship: true)
      @completed_tasks = Task.where(completed: true).group(:user_id).order("count(user_id) DESC")
    end
  end

  def all_users
    
    @completed_tasks = Task.where(completed: true).group(:user_id)
    puts "1111"
    puts @completed_tasks.class
  end
end
