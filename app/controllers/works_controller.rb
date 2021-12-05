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
      redirect_to works_path
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
  
  def new_work # 業務年度を紐づけるため（params[:fiscalyear]を与えるため）newアクションではなく、new_workアクションを定義
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
    if params[:fiscalyear].blank?
      @work = Work.find(params[:id])
    else
      @work = Work.where(firstid: Work.find(params[:id]).firstid).find_by(fiscalyear: params[:fiscalyear])
    end
    redirect_to work_path(@work.id)
  end
  
  def edit
    @work = Work.find(params[:id])
    @staffs_in_department = User.where(department_id: current_user.department.id)
  end
  
  def update
    if params[:commit] == "更新"
      @work = Work.find(params[:id])
      @work.update(work_params)
      @staffs_in_department = User.where(department_id: current_user.department.id)
      redirect_to  work_path(params[:id])
    elsif params[:commit].include?("フロー追加")
      number = params[:commit].gsub(/[^\d]/, "").to_i
      @work = Work.find(params[:id])
      @work.update(work_params)
      @workflows = @work.workflows.order(number)
      
      @workflows.where("number >= ?", number).each do |workflow|
        workflow.number += 1
        workflow.save
      end
      Workflow.create(work_id: @work.id, number: number)
      redirect_to edit_work_path(@work.id)
    elsif params[:commit].include?("削除")
      number = params[:commit].gsub(/[^\d]/, "").to_i
      @work = Work.find(params[:id])
      @work.update(work_params)
      @workflow = @work.workflows.find_by(number: number)
      @workflow.destroy
      
      @workflows = @work.workflows.order(number)
      
      @workflows.where("number >= ?", number).each do |workflow|
        workflow.number -= 1
        workflow.save
      end
      redirect_to edit_work_path(@work.id)
    end
  end
  
  #以下、業務のコピー
  def copy
    @department = current_user.department
  end
  
  def copied #業務フローのコピーが未実装
    @department = current_user.department
    @works_in_department = Work.where(department_id: @department.id, fiscalyear: params[:copied_fiscalyear])
    
    if params[:copied_fiscalyear].blank? || params[:new_copy_fiscalyear].blank?
      flash.now[:danger] = "「コピー元の年度」及び「コピー先の年度」を全て選択してください"
      render :copy
    else
      begin
        ActiveRecord::Base.transaction do
          @works_in_department.each do |work_in_department|
            @copy_work_in_department = Work.create!(name: work_in_department.name, summary: work_in_department.summary, 
                                                   period: work_in_department.period, user_id: nil, department_id: work_in_department.department_id,
                                                   firstid: work_in_department.firstid, fiscalyear: params[:new_copy_fiscalyear],
                                                   task: work_in_department.task)
              work_in_department.workflows.order(:number).each do |workflow|
                @copy_workflow = Workflow.create!(work_id: @copy_work_in_department.id, content: workflow.content, note: workflow.note,
                                                 filepath: workflow.filepath, number: workflow.number)
              end
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
