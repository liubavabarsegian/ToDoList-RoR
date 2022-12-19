# frozen_string_literal: true

# class SessionsController
class SessionsController < ApplicationController
  before_action :no_autorize, only: %i[new create]
  before_action :autorize, only: :destroy
  def new; end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def create
    @user = User.find_by(email: params[:email])
    puts 'USERS IS SIGNED IN' if user_signed_in?
    puts 'USER IS NOT SIGNED IN' unless user_signed_in?
    if !!@user && @user.authenticate(params[:password])
      if @user.email_confirmed?
        session[:user_id] = @user.id
        session[:user_nick] = @user.nick
        flash[:success] = 'you have successfully logged in'
        redirect_to root_path
      else
        flash[:error] = 'Confirm your email'
        redirect_to new_path
      end
    else
      flash[:error] = 'Incorrect password or email'
      redirect_to login_path
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def destroy
    puts 'USERS IS SIGNED IN' if user_signed_in?
    puts 'USER IS NOT SIGNED IN' unless user_signed_in?
    session.delete :user_id
    flash[:success] = 'Successful exit'
    redirect_to root_path
  end
end
