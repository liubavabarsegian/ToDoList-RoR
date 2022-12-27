# frozen_string_literal: true

# class SessionsController
class SessionsController < ApplicationController
  before_action :no_autorize, only: %i[new create]
  before_action :autorize, only: :destroy
  def new; end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def create
    @user = User.find_by(email: params[:email])
    if !!@user && @user.authenticate(params[:password])
      if @user.email_confirmed?
        session[:user_id] = @user.id
        session[:user_nick] = @user.nick
        flash[:success] = t(:you_have_successfully_logged_in)
        redirect_to root_path
      else
        flash[:error] = t(:confirm_you_email)
        redirect_to login_path
      end
    else
      flash[:error] = t(:incorrect_password_or_email)
      redirect_to login_path
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def destroy
    redirect_to login_path unless user_signed_in?
    return unless user_signed_in?

    session.delete :user_id
    flash[:success] = t(:successfull_exit)
    redirect_to root_path
  end
end
