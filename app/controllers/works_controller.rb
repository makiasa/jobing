class WorksController < ApplicationController
  def new
    @work = Work.new
    @workflow = Workflow.new
  end
  
  def show
    @work = current_user.works.find(params[:id])
    @works = Work.where(firstid: @work.firstid)
    @workflows = @work.workflows
  end
  
  def edit
    @work = Work.find(params[:id])
    @workflows = @work.workflows 
  end
  
  def update
    @department = Department.find(params[:department_id])
    @work = @department.works.find_by(firstid: params[:id]).update(work_params)
    @workflows = @work.workflows 
  end
  
  private
  def work_params
    params.require(:work).permit(:summary,:task)
  end
  
  def workflow_params
    params.require(:workflow).permit(:work_id,:content,:deadline,:status).merge(user_id: current_user.id)
  end
end
