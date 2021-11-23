# まだ作成途中で未完成（作成後のメッセージ、"current_user.todos.new"の整理など）
class TodosController < ApplicationController
  def index
    @todos = current_user.todos.all
    @not_start_todos = @todos.where(status: 0).order(:deadline)
    @progress_todos = @todos.where(status: 1).order(:deadline)
    @finished_todos = @todos.where(status: 2).order(:deadline)
  end
  
  def new
    @todo = Todo.new
    @myworks = current_user.works.where(department_id: current_user.department_id)
  end
  
  def new_todo
    @todo = Todo.new(work_id: params[:id])
    @work = Work.find(params[:id])
  end
  
  def new_todo_create
    @todo = current_user.todos.new(new_todo_params)
    if @todo.save
      redirect_to  work_path(params[:work_id])
    else
      render :new_todo
    end
  end
  
  def create
    @todo = current_user.todos.new(todo_params)
    if @todo.save
      redirect_to  pages_home_path
    else
      render :new
    end
  end
  
  def edit
    @todo = Todo.find(params[:id])
    @myworks = current_user.works.where(department_id: current_user.department_id)
  end
  
  def update
    @todo = Todo.find(params[:id])
    @todo.update(todo_params)
    
    redirect_to  pages_home_path
  end
  
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to  pages_home_path
  end
  
  private
  def todo_params
    params.require(:todo).permit(:work_id,:content,:deadline,:status).merge(user_id: current_user.id)
  end
  
  def new_todo_params
    params.permit(:work_id,:content,:deadline,:status).merge(user_id: current_user.id)
  end
end
