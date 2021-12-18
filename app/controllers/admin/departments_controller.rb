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
    @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
    if params[:department][:ancestry].present?
      @parent_department = Department.find(params[:department][:ancestry]) 
    else
      @department.ancestry = nil
    end
    render :new unless @department.valid?
  end

  def edit
    @department = Department.find(params[:id])
    @parent_department = @department.parent
    @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
  end
  
  def create
    @department = Department.new(department_params)
    @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
    if params[:department][:ancestry].blank?
      @department.ancestry = nil
    end
    
    if params[:back].present?
      render :new
      return
    end
    
    if @department.save
      if params[:department][:ancestry].present? && Department.find(params[:department][:ancestry]).root?
        @department.update(ancestry: "#{params[:department][:ancestry]}")
      elsif params[:department][:ancestry].present? && Department.find(params[:department][:ancestry]).has_parent?
        @department.update(ancestry: "#{Department.find(params[:department][:ancestry]).parent.id}/#{params[:department][:ancestry]}")
      end
      redirect_to admin_department_path(@department), notice: "部署「#{@department.name}」を登録しました"
    else
      render :new
    end
  end
  
  def update
    @department = Department.find(params[:id])
    @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
    
    if @department.update(department_params)
      if params[:department][:ancestry].present? && Department.find(params[:department][:ancestry]).root?
        @department.update(ancestry: "#{params[:department][:ancestry]}")
      elsif params[:department][:ancestry].present? && Department.find(params[:department][:ancestry]).has_parent?
        @department.update(ancestry: "#{Department.find(params[:department][:ancestry]).parent.id}/#{params[:department][:ancestry]}")
      end
      redirect_to admin_department_path(@department), notice: "部署「#{@department.name}」を更新しました"
    else
      if params[:department][:ancestry].blank?
        @department.ancestry = nil
        @department.update(department_params_except_column_ancestry)
        redirect_to admin_department_path(@department), notice: "部署「#{@department.name}」を更新しました"
      else
        render :edit
      end
    end
  end
  
  def destroy
    @department = Department.find(params[:id])
    @department.destroy
    redirect_to admin_departments_path, notice: "部署「#{@department.name}」を削除しました"
  end

  private
  def department_params
    params.require(:department).permit(:name, :number, :ancestry , :startdate, :enddate, :firstid)
  end
  
  def department_params_except_column_ancestry
    params.require(:department).permit(:name, :number, :startdate, :enddate, :firstid)
  end
  
  def require_admin
    redirect_to login_path unless current_user.admin?
  end
end
