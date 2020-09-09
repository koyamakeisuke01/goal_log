class TasksController < ApplicationController
  
  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page]).per(5).order("updated_at DESC")
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

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice:  "タスクを削除しました。"
  end

  private
  def task_params
    params.require(:task).permit(:title, :description).merge(user_id: current_user.id)
  end

end
