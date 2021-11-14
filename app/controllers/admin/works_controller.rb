class Admin::WorksController < ApplicationController
  before_action :require_admin
  
  def new
    @work = Work.new
  end
  
  def create
    @work = Work.new(work_params)
    @work.save
  end
  
  def copy
    @all_departments = Department.all
  end
  
  def copied
    @works_in_department = Work.where(department_id: params[:department_id], fiscalyear: params[:copied_fiscalyear])
    
    @works_in_department.each do |work_in_department|
      work_in_department.deep_dup.update(fiscalyear: params[:new_copy_fiscalyear], user_id: nil)
    end
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
  def work_params
    params.require(:work).permit(:name,:summary, :period, :admin, :user_id, :department_id,:firstid,:fiscalyear,:task)
  end
  
  def require_admin
    redirect_to login_path unless current_user.admin?
  end
end
