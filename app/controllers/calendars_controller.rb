# frozen_string_literal: true

class CalendarsController < ApplicationController
  def month
    redirect_to login_path unless user_signed_in?
    start_date = params.fetch(:due, Date.today).to_date
    @tasks = Task.where(due: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end

  def week
    redirect_to login_path unless user_signed_in?
    start_date = params.fetch(:due, Date.today).to_date
    @tasks = Task.where(due: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
  end
end
