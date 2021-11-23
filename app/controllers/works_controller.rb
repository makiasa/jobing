class WorksController < ApplicationController
  include Constant
  
  def index
    if  4 <= Date.today.month && Date.today.month <= 12
      @current_fiscalyear = Date.today.year
    else
      @current_fiscalyear = Date.today.year - 1
    end
    
    @works_in_department = Work.where(department_id: current_user.department.id, fiscalyear: @current_fiscalyear)
  end
  
  def move_index
    if request.post? && params[:fiscalyear] != ""
      redirect_to "/works/index/#{params[:fiscalyear]}"
    elsif request.post? && params[:fiscalyear] == ""
      render :move_index
    else
      @works_in_department = Work.where(department_id: current_user.department.id, fiscalyear: params[:id])
      @current_fiscalyear = params[:id]
    end
  end
  
  def new
    @work = Work.new
    @workflows = @work.workflows.build
    @staffs_in_department = User.where(department_id: current_user.department.id)
  end
  
  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end
  
  def show
    @work = Work.find(params[:id])
    @workflows = @work.workflows.order(:number)
    @todos = @work.todos.where("deadline >= ?", Date.today).order(:deadline)
    @over_todos = @work.todos.where("deadline < ?", Date.today).order(:deadline)
    
    @works = Work.where(firstid: @work.firstid).order(fiscalyear: "DESC")
    @fiscalyears = @works.map{|work| [FISCAL_YEARS[work.fiscalyear] , work.fiscalyear] }
  end
  
  def move_show
    @work = Work.where(firstid: Work.find(params[:id]).firstid).find_by(fiscalyear: params[:fiscalyear])
    if @work
      redirect_to work_path(@work.id)
    else
      render :show
    end
  end
  
  def edit
    @work = Work.find(params[:id])
    @staffs_in_department = User.where(department_id: current_user.department.id)
  end
  
  def update
    @work = Work.find(params[:id])
    @work.update(work_params)
    
    redirect_to  work_path(params[:id])
  end
  
  #以下、業務のコピー
  def copy
    @department = current_user.department
  end
  
  def copied
    @department = current_user.department
    @works_in_department = Work.where(department_id: @department.id, fiscalyear: params[:copied_fiscalyear])
    
    @works_in_department.each do |work_in_department|
      work_in_department.deep_dup.update(fiscalyear: params[:new_copy_fiscalyear], user_id: nil)
    end
    
    redirect_to "/works/index/#{params[:new_copy_fiscalyear]}"
  end
  
  def add_flow
    @work = Work.find(params[:id])
    @workflows = @work.workflows.order(:number)
    
    @workflows.each do |workflow|
      if workflow.number >= params[:number].to_i
        workflow.number += 1
        workflow.save
      end
    end
    
    Workflow.create(work_id: @work.id, number: params[:number].to_i)
    
    render :edit
  end
  
  def remove_flow
    @work = Work.find(params[:id])
    @workflow = @work.workflows.find_by(number: params[:number].to_i)
    @workflow.destroy
    
    @workflows = @work.workflows.order(:number)
    
    @workflows.each do |workflow|
      if workflow.number >= params[:number].to_i
        workflow.number -= 1
        workflow.save
      end
    end
    render :edit
  end
  
  private
  def work_params
    params.require(:work).permit(:name,:period,:summary,:task,:user_id,
                                workflows_attributes: [:id,:number,:content,:note,:filepath,:_destroy])
  end
end
