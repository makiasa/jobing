class Admin::WorksController < ApplicationController
  before_action :require_admin
  
  def new
  end
  
  def create
  end
  
  def copy
    # 以下、考え中
    # @work = Work.find(params[:id])
    # @copied_work = @work.deep_dup
  end

  def edit
  end
  
  def update
  end

  def show
  end

  def index
  end
  
  private
  def require_admin
    redirect_to login_path unless current_user.admin?
  end
end
