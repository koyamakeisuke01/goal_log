class TasksController < ApplicationController
  
  def index
    @tasks = Task.includes(:user).order("updated_at DESC")
    @task = Task.new
  end
end
