class CompetitionsController < ApplicationController
  include FriendsHelper



  def friends
    redirect_to login_path unless user_signed_in?
    if user_signed_in?
      arr = Task.where(completed: true).select{|task| User.find(task.user_id).is_friend?(current_user)}
      @completed_tasks =  Task.where(id: arr.map(&:id)).group(:user_id)
    end
  end

  def all_users
    table_name = Task.arel_table
    @completed_tasks = Task.where(completed: true).group(:user_id)
  end
end
