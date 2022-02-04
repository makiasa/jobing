class UsersController < ApplicationController
  def new
  end
  
  def create
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update #パスワード変更用
    @user = User.find(params[:id])
    if @user&.authenticate(params[:user][:current_password]) && @user.update(user_params)
      redirect_to pages_home_path
    else
      flash.now[:danger] = "パスワードが変更できませんでした"
      render :edit
    end
  end
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation).merge(id: current_user.id)
  end
end