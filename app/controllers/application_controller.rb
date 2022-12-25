# frozen_string_literal: true

# class of controller
class ApplicationController < ActionController::Base
  include ApplicationHelper
  
  class ApplicationController < ActionController::Base
    around_action :switch_locale
    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale
      I18n.with_locale(locale, &action)
    end
  end

  private

  def current_user
    @current_user || User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def user_signed_in?
    current_user.present?
  end

  def autorize
    return if user_signed_in?

    flash[:warning] = 'You are not logged in'
    redirect_to root_path
  end

  def no_autorize
    return unless user_signed_in?

    flash[:warning] = 'You are already logged in'
  end

  helper_method :current_user, :user_signed_in?
end
