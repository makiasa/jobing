class UsersController < ApplicationController
  #パスワード変更機能が未実装
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @user.save
    redirect_to pages_home_path
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.password = params[:password]
    @user.save
    redirect_to pages_home_path
  end
  
  def user_params
    params.require(:user).permit(:password).merge(id: current_user.id)
  end
end