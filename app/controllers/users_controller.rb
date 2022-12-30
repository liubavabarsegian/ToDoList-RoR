# frozen_string_literal: true

# users
class UsersController < ApplicationController
  include UsersHelper
  include FriendsHelper
  before_action :set_user, only: %i[show edit update destroy]
  # before_action :set_color, only: %i[show]

  # GET /users or /users.json
  def index
    redirect_to login_path unless user_signed_in?
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    redirect_to login_path unless user_signed_in?

    @pending_tasks = Task.where(user_id: @user.id, completed: false)
    @completed_tasks = Task.where(user_id: @user.id, completed: true)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  # rubocop:disable Metrics/AbcSize
  def create
    @user = User.new(user_params)
    if !@user.save
      flash[:error] = @user.errors.full_messages.join('! ')
      redirect_to new_path
    else
      UserMailer.registration_confirmation(@user).deliver_later
      flash[:success] = t(:email_sent)
      redirect_to root_path
    end
  end
  # rubocop:enable Metrics/AbcSize

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: t(:user_was_updated) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: t(:user_was_destroyed) }
      format.json { head :no_content }
    end
  end

  def sounds; end

  def save_sounds
    @user = User.find(current_user.id)
    params.permit(:success_sound, :failure_sound)
    @user.update_attribute(:success_sound, params[:success_sound])
    @user.update_attribute(:failure_sound, params[:failure_sound])
    redirect_to root_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:nick, :name, :surname, :email, :password, :password_confirmation)
  end
end
