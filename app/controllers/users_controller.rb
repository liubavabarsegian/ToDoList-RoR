# frozen_string_literal: true

class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users or /users.json
  def index
    redirect_to login_path unless user_signed_in?
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    redirect_to login_path unless user_signed_in?
    if user_signed_in?
      @pending_tasks = Task.where(user_id: @user.id, completed: false)
      @completed_tasks = Task.where(user_id: @user.id, completed: true)
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if !@user.save
      flash[:error] = @user.errors.full_messages.join('! ')
      redirect_to new_path
    else
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = 'На указанную почту выслано письмо. Подтвердите почту, пожалуйста.'
      # session[:user_id] = @user.id
      # session[:user_nick] = @user.nick
      # flash[:success] = "User was successfully created. Welcome, #{@user.email}!"
      redirect_to root_path
    end

    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to user_url(@user), notice: 'User was successfully created.' }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
 
    puts @color;
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: 'User was successfully updated.' }
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
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:nick, :name, :surname, :email, :password, :color)
  end
end
