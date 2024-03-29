# frozen_string_literal: true

# tasks
class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    redirect_to login_path unless user_signed_in?
    return unless user_signed_in?

    @tasks = Task.all
    @option = 'today'
    @tasks = Task.all.where(user_id: current_user.id)
    @pending_tasks = Task.where(user_id: current_user.id).count
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    redirect_to login_path unless user_signed_in?
    return unless user_signed_in?

    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks or /tasks.json
  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def create
    redirect_to login_path unless user_signed_in?
    return unless user_signed_in?

    if user_signed_in?
      @task = Task.new(task_params)
      @task.user_id = current_user.id
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: t(:task_was_created) }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    redirect_to login_path unless user_signed_in?
    return unless user_signed_in?

    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: t(:task_was_updated) }
        # format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    redirect_to login_path unless user_signed_in?
    return unless user_signed_in?

    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: t(:task_was_destroyed) }
    end
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def complete
    redirect_to login_path unless user_signed_in?
    return unless user_signed_in?

    @tasks = Task.all.where(user_id: current_user.id)
    @task = Task.find(params[:task])
    @task.update_attribute(:completed, true)
    @task.update_attribute(:completed_time, DateTime.now)
    @option = 'today'

    respond_to do |format|
      format.html         { render :complete } # renders `page.html.erb`
      format.turbo_stream { render :complete } # renders `page.turbo_stream.erb`
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def uncomplete
    redirect_to login_path unless user_signed_in?
    return unless user_signed_in?

    @tasks = Task.all.where(user_id: current_user.id)
    @task = Task.find(params[:task])
    @task.update_attribute(:completed, false)
    @task.update_attribute(:completed_time, nil)

    @option = 'today'
    respond_to do |format|
      format.html         { render :uncomplete } # renders `page.html.erb`
      format.turbo_stream { render :uncomplete } # renders `page.turbo_stream.erb`
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def choose
    @tasks = Task.all.where(user_id: current_user.id)
    redirect_to login_path unless user_signed_in?
    return unless user_signed_in?

    @option = page_params[:option]

    respond_to do |format|
      format.html         { render :choose } # renders `page.html.erb`
      format.turbo_stream { render :choose } # renders `page.turbo_stream.erb`
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:title, :description, :due, :reminder, :reminder_time, :completed)
  end

  def page_params
    params.permit(:option)
  end
end
