class TasksController < ApplicationController
  
  def index
    @tasks = Task.includes(:user).order("updated_at DESC")
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.valid?
      @task.save
      redirect_to tasks_path
    else
      @tasks = Task.includes(:user).order("updated_at DESC")
      render :index
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :description).merge(user_id: current_user.id)
  end

end
