class WorksController < ApplicationController
  def new
    @work = Work.new
    @workflow = Workflow.new
  end
  
  def show
    @departments = Department.where(firstid: current_user.department.firstid)
    @department = Department.find(params[:department_id])
    @work = @department.works.find_by(firstid: params[:id])
    @workflows = @work.workflows
  end
  
  def edit
    @department = Department.find(params[:department_id])
    @work = @department.works.find_by(firstid: params[:id])
    @workflows = @work.workflows 
  end
  
  def update
    @department = Department.find(params[:department_id])
    @work = @department.works.find_by(firstid: params[:id]).update(work_params)
    @workflows = @work.workflows 
  end
  
  private
  def work_params
    params.require(:work).permit(:work_id,:content,:deadline,:status).merge(user_id: current_user.id)
  end
  
  def workflow_params
    params.require(:workflow).permit(:work_id,:content,:deadline,:status).merge(user_id: current_user.id)
  end
end
