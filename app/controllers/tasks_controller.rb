class TasksController < ApplicationController
  before_action :login_check, only: [:index, :todo, :done]
  
  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page]).per(5).order("updated_at DESC")
    @task = Task.new
  end

  def todo
    @q = current_user.tasks.where(done: false).ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page]).per(5).order("updated_at DESC")
    @todo_tasks = current_user.tasks.where(done: false)
    @done_tasks = current_user.tasks.where(done: true)
    # binding.pry
    @task = Task.new
  end

  def done
    @q = current_user.tasks.where(done: true).ransack(params[:q])
    @tasks = @q.result(distinct: true).page(params[:page]).per(5).order("updated_at DESC")
    @todo_tasks = current_user.tasks.where(done: false)
    @done_tasks = current_user.tasks.where(done: true)
    @task = Task.new
  end

  def check
    check = Task.find(params[:id])
    if check.done
      check.update(done: false)
      redirect_to done_task_path
    else
      check.update(done: true)
      redirect_to todo_task_path
    end
  end

  def create
    @task = Task.new(task_params)
    if @task.valid?
      @task.save
      redirect_to todo_task_path(:id)
    else
      @q = current_user.tasks.where(done: false).ransack(params[:q])
      @tasks = @q.result(distinct: true).page(params[:page]).per(5).order("updated_at DESC")
      @todo_tasks = current_user.tasks.where(done: false)
      @done_tasks = current_user.tasks.where(done: true)
      render :todo
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to todo_task_path(:id)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to todo_task_path(:id), notice:  "タスクを削除しました。"
  end

  private
  def login_check
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
  
  def task_params
    params.require(:task).permit(:title).merge(user_id: current_user.id)
  end

end
