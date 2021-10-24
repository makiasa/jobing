class WorksController < ApplicationController
  def show
    @departments = Department.where(firstid: current_user.department.firstid)
    @department = Department.find_by(id: params[:department_id])
    @work = Work.find_by(department_id: params[:department_id] ,firstid: params[:id])
    @workflows = @work.workflows
  end
end
