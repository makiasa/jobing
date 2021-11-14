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
    end
  end
  
  def new
    @work = Work.new
    @workflows = @work.workflows.build
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
  end
  
  def update
    @work = Work.find(params[:id])
    @work.update(work_params)
    
    redirect_to  work_path(params[:id])
  end
  
  private
  def work_params
    params.require(:work).permit(:name,:period,:summary,:task,
                                workflows_attributes: [:id,:number,:content,:note,:filepath,:_destroy])
  end
end
