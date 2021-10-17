class TodosController < ApplicationController
  def new
    @todo = Todo.new
  end
  
  def create
    @todo = current_user.todos.new(todo_params)
    
    if @todo.save
      redirect_to  pages_home_path, success: '投稿に成功しました'
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end
end
