class Admin::DepartmentsController < ApplicationController
  before_action :require_admin
  
  def index
    @departments = Department.all.order(:number)
  end
  
  def show
    @department = Department.find(params[:id])
  end
  
  def new
    @department = Department.new
    @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
  end
  
  def confirm_new
    @department = Department.new(department_params)
    render :new unless @department.valid?
  end

  def edit
    @department = Department.find(params[:id])
  end
  
  def create
    @department = Department.new(department_params)
    
    if params[:back].present?
      render :new
      return
    end
    
    if @department.save
      redirect_to admin_department_path(@department), notice: "ユーザー「#{@department.name}」を登録しました"
    else
      render :new
    end
  end
  
  def update
     @department = Department.find(params[:id])
    
    if @department.update(department_params)
      redirect_to admin_department_path(@department), notice: "ユーザー「#{@department.name}」を更新しました"
    else
      render :edit
    end
  end
  
  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    redirect_to admin_departments_path, notice: "ユーザー「#{@department.name}」を削除しました"
  end

  private
  def department_params
    params.require(:department).permit(:name, :number, :startdate, :enddate, :firstid)
  end
  
  def require_admin
    redirect_to login_path unless current_user.admin?
  end
end
