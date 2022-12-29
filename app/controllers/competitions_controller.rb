# frozen_string_literal: true

# competitions
class CompetitionsController < ApplicationController
  include FriendsHelper

  def friends
    redirect_to login_path unless user_signed_in?

    arr = Task.where(completed: true).select { |task| User.find(task.user_id).is_friend?(current_user) || task.user_id == current_user.id}.select{|task| task.completed_time.to_date.day == Date.today.day }
    @completed_tasks = Task.where(id: arr.map(&:id)).group(:user_id)
  end

  def all_users
    redirect_to login_path unless user_signed_in?
    arr = Task.where(completed: true).select{|task| task.completed_time.to_date.day == Date.today.day }
    @completed_tasks = Task.where(id: arr.map(&:id)).group(:user_id)
  end
end
