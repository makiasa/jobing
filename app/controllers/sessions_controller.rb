class SessionsController < ApplicationController
  skip_before_action :login_required
  
  def new
  end

  def create
    user = User.find_by(number: session_params[:number])
    
    if user&.authenticate(session_params[:password]) && user.admin?
      log_in(user)
      redirect_to admin_pages_home_path
    elsif user&.authenticate(session_params[:password])
      log_in(user)
      redirect_to pages_home_path #, notice: "ログインしました"
    else
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end


  private
  
  def session_params
    params.require(:session).permit(:number, :password)
  end
  
end
