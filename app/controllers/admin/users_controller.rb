class Admin::UsersController < ApplicationController
  before_action :require_admin
  
  def index
    @users = User.all
  end
  
  def search
    @users = User.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def confirm_new
    @user = User.new(user_params)
    render :new unless @user.valid?
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    
    if params[:back].present?
      render :new
      return
    end
    
    if @user.save
      redirect_to admin_user_path(@user), notice: "職員「#{@user.full_name}」を登録しました"
    else
      render :new
    end
  end
  
  def update
     @user = User.find(params[:id])
    
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "職員「#{@user.full_name}」を更新しました"
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "職員「#{@user.full_name}」を削除しました"
  end

  private
  def user_params
    params.require(:user).permit(:number,:firstname, :lastname,:furigana_firstname, :furigana_lastname, 
                                  :email, :department_id, :position, :admin, :adopt_date,:retire_date,
                                  :password, :password_confirmation)
  end
  
  def require_admin
    redirect_to login_path unless current_user.admin?
  end
end

