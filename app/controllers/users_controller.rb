class UsersController < ApplicationController
  #パスワード変更機能が未実装
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to pages_home_path
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user&.authenticate(params[:current_password])
      @user.update(user_params)
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