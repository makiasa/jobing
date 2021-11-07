# まだ作成途中で未完成（作成後のメッセージなど）
class TodosController < ApplicationController
  def index
    @todos = current_user.todos.all
  end
  
  def new
    @todo = Todo.new
    @myworks = current_user.works.where(department_id: current_user.department_id)
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
  
  private
  def todo_params
    params.require(:todo).permit(:work_id,:content,:deadline,:status).merge(user_id: current_user.id)
  end
end
