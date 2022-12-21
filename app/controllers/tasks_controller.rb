# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all
    redirect_to login_path unless user_signed_in?
    return unless user_signed_in?

    @option = page_params[:option]
    puts "AAA"
    puts page_params
    puts @option
    @tasks = Task.where(user_id: current_user.id)
    @pending_tasks = Task.where(user_id: current_user.id).count
  end

  # GET /tasks/1 or /tasks/1.json
  def show; end

  # GET /tasks/new
  def new
    redirect_to login_path unless user_signed_in?
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks or /tasks.json
  def create
    redirect_to login_path unless user_signed_in?

    if user_signed_in?
      @task = Task.new(task_params)
      @task.user_id = current_user.id
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: 'Task was successfully created.' }
        # format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: 'Task was successfully updated.' }
        # format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  def complete
    @tasks = Task.all
    @task = Task.find(params[:task])
    @task.update_attribute(:completed, true)
    @task.update_attribute(:completed_time, DateTime.now)

    respond_to do |format|
      format.html         { render :complete } # renders `page.html.erb`
      format.turbo_stream { render :complete } # renders `page.turbo_stream.erb`
    end
  end

  def uncomplete
    @tasks = Task.all
    @task = Task.find(params[:task])
    @task.update_attribute(:completed, false)
    @task.update_attribute(:completed_time, nil)
    respond_to do |format|
      format.html         { render :uncomplete } # renders `page.html.erb`
      format.turbo_stream { render :uncomplete } # renders `page.turbo_stream.erb`
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
    params.permit(:option, :value)
  end
end
