# frozen_string_literal: true

module UsersHelper
      def confirm_email
        user = User.find_by_confirm_token(params[:id])
        if user
          user.email_activate
          flash[:success] = "Welcome, #{user.nick}"
          redirect_to home_path
        else
          flash[:error] = 'No user found with such email'
          redirect_to new_path
        end
      end
end
