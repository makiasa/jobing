class WorksController < ApplicationController
  include Constant
  
  def index
    if  4 <= Date.today.month && Date.today.month <= 12
      @current_fiscalyear = Date.today.year
    else
      @current_fiscalyear = Date.today.year - 1
    end
    
    @works_in_department = Work.where(department_id: current_user.department.id, fiscalyear: @current_fiscalyear)
    @myworks = @works_in_department.where(user_id: current_user.id)
  end
  
  def move_index
    if request.post? && params[:fiscalyear] != ""
      redirect_to "/works/index/#{params[:fiscalyear]}"
    elsif request.post? && params[:fiscalyear] == ""
      render :move_index
    else
      @works_in_department = Work.where(department_id: current_user.department.id, fiscalyear: params[:id].to_i)
      @myworks = @works_in_department.where(user_id: current_user.id)
      @current_fiscalyear = params[:id].to_i
    end
  end
  
  def new
    @work = Work.new
    @staffs_in_department = User.where(department_id: current_user.department.id)
  end
  
  def create
    @work = Work.new(work_params)
    @staffs_in_department = User.where(department_id: current_user.department.id)
    if @work.save
      @work.update(firstid: @work.id)
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end
  
  def new_work
    @work = Work.new
    @fiscalyear = params[:fiscalyear].to_i
    @staffs_in_department = User.where(department_id: current_user.department.id)
  end
  
  def new_work_create
    @work = Work.new(new_work_params)
    @fiscalyear = params[:fiscalyear].to_i
    @staffs_in_department = User.where(department_id: current_user.department.id)
    if @work.save
      @work.update(firstid: @work.id)
      redirect_to  "/works/index/#{@fiscalyear}"
    else
      render :new_work
    end
  end
  
  
  def show
    @work = Work.find(params[:id])
    @workflows = @work.workflows.order(:number)
    @todos = @work.todos.where(user_id: current_user.id).where("deadline >= ?", Date.today).order(:deadline)
    @over_todos = @work.todos.where(user_id: current_user.id).where("deadline < ?", Date.today).order(:deadline)
    
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
    @staffs_in_department = User.where(department_id: current_user.department.id)
    redirect_to  work_path(params[:id])
  end
  
  #以下、業務のコピー
  def copy
    @department = current_user.department
  end
  
  def copied
    @department = current_user.department
    @works_in_department = Work.where(department_id: @department.id, fiscalyear: params[:copied_fiscalyear])
    
    if params[:copied_fiscalyear].blank? || params[:new_copy_fiscalyear].blank?
      flash.now[:danger] = "「コピー元の年度」及び「コピー先の年度」を全て選択してください"
      render :copy
    else
      begin
        ActiveRecord::Base.transaction do
          @works_in_department.each do |work_in_department|
            work_in_department.deep_dup.update!(fiscalyear: params[:new_copy_fiscalyear], user_id: nil)
          end
        end
          flash[:success] = "コピーに成功しました"
          redirect_to "/works/index/#{params[:new_copy_fiscalyear]}"
        rescue ActiveRecord::RecordInvalid => e
          flash.now[:danger] = "コピーに失敗しました。理由：#{e.message}"
          render :copy
      end
    end
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
    redirect_to edit_work_path(@work.id)
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
    redirect_to edit_work_path(@work.id)
  end
  
  def destroy
    @work = Work.find(params[:id])
    @fiscalyear = @work.fiscalyear
    @work.destroy
    redirect_to  "/works/index/#{@fiscalyear}"
  end
  
  private
  def work_params
    params.require(:work).permit(:name,:period,:summary,:task,:user_id,:fiscalyear,:department_id,:firstid,
                                workflows_attributes: [:id,:number,:content,:note,:filepath,:_destroy])
  end
  
  def new_work_params
    params.permit(:name,:period,:summary,:task,:user_id,:fiscalyear,:department_id,:firstid)
  end
end
