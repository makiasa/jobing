# まだ作成途中で未完成（作成後のメッセージ、"current_user.todos.new"の整理など）
class TodosController < ApplicationController
  def index
  end
  
  def move_index
    if request.post? && params[:status] != ""
      redirect_to "/todos/index/#{params[:status]}"
    elsif request.post? && params[:status] == ""
      redirect_to todos_path
      flash[:danger] = "作業状況を選択してください"
    else
      @todos = current_user.todos.where(status: params[:status]).order(:deadline).page(params[:page]).per(10)
      @status = params[:status].to_i
    end
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
    @work = Work.find(params[:work_id])
    if @todo.save
      redirect_to  work_path(params[:work_id])
    else
      render :new_todo
    end
  end
  
  def create
    @todo = current_user.todos.new(todo_params)
    @myworks = current_user.works.where(department_id: current_user.department_id)
    if @todo.save
      redirect_to  pages_home_path
    else
      render :new
    end
  end
  
  def show
    @todo = Todo.find(params[:id])
  end
  
  def edit
    @todo = Todo.find(params[:id])
    @myworks = current_user.works.where(department_id: current_user.department_id)
  end
  
  def update
    @todo = Todo.find(params[:id])
    @myworks = current_user.works.where(department_id: current_user.department_id)
    
    if @todo.update(todo_params)
      redirect_to  pages_home_path
    else
      render :edit
    end
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
