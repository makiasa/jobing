class WorkflowsController < ApplicationController
  def new
    @workflow = Workflow.new
    
    @departments = Department.where(firstid: current_user.department.firstid)
    @department = Department.find(params[:department_id])
    @work = @department.works.find_by(firstid: params[:id])
    @workflows = @work.workflows
  end
  
  def edit
  end
end
