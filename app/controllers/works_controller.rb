class WorksController < ApplicationController
  def show
    @departments = Department.where(firstid: current_user.department.firstid)
    @department = Department.find_by(id: params[:department_id])
    @work = @department.works.find_by(firstid: params[:id])
    @workflows = @work.workflows
  end
end
