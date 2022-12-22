class CompetitionsController < ApplicationController
  def friends
    redirect_to login_path unless user_signed_in?
    if user_signed_in?
      @completed_tasks = Task.where(completed: true)
      @friends = Friend.all.where(user_id: current_user.id, friendship: true) + Friend.all.where(friend_id: current_user.id, friendship: true)
    end
  end

  def all_users
    @completed_tasks = Task.where(completed: true).group(:user_id).order("count(created_at) DESC")
    # @completed_tasks.each do |key, value|
    #   key.user_id = User.where(id: key.user_id).nick
    # end
  end
end
