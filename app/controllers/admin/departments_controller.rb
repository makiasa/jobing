class Admin::DepartmentsController < ApplicationController
  before_action :require_admin
  
  def index
    @departments = Department.all.order(:number)
  end
  
  def search
    @departments = Department.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end
  
  def show
    @department = Department.find(params[:id])
  end
  
  def new
    @department = Department.new
    @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
    
    @reference_departments = Department.all.order(:number)
  end
  
  def confirm_new
    @department = Department.new(department_params)
    @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
    @reference_departments = Department.all.order(:number)
    if params[:department][:ancestry].present?
      @parent_department = Department.find(params[:department][:ancestry]) 
    else
      @department.ancestry = nil
    end
    render :new unless @department.valid?
  end
  
  def create
    @department = Department.new(department_params)
    @department.ancestry = nil  if params[:department][:ancestry].blank?
    
    if params[:back].present? #確認画面の「戻る」ボタンがトリガー
      @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
      @reference_departments = Department.all.order(:number)
      render(:new) and return 
    end
    
    if @department.save
      if params[:department][:ancestry].present? && Department.find(params[:department][:ancestry]).root?
        @department.update(ancestry: "#{params[:department][:ancestry]}")
      elsif params[:department][:ancestry].present? && Department.find(params[:department][:ancestry]).has_parent?
        @department.update(ancestry: "#{Department.find(params[:department][:ancestry]).parent.id}/#{params[:department][:ancestry]}")
      end
      redirect_to admin_department_path(@department), notice: "部署「#{@department.name}」を登録しました"
    else
      @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
      render :new
    end
  end
  
  def edit
    @department = Department.find(params[:id])
    @parent_department = @department.parent
    @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
    
    @reference_departments = Department.all.order(:number)
  end
  
  def update
    @department = Department.find(params[:id])
    if @department.update(department_params)
      if params[:department][:ancestry].present? && Department.find(params[:department][:ancestry]).root?
        @department.update(ancestry: "#{params[:department][:ancestry]}")
      elsif params[:department][:ancestry].present? && Department.find(params[:department][:ancestry]).has_parent?
        @department.update(ancestry: "#{Department.find(params[:department][:ancestry]).parent.id}/#{params[:department][:ancestry]}")
      end
      redirect_to admin_department_path(@department), notice: "部署「#{@department.name}」を更新しました"
    else
      if params[:department][:ancestry].blank? #1.update失敗の理由が「params[:department][:ancestry]が""（空の文字列）」の場合を想定
        @department.ancestry = nil
        if @department.save
          redirect_to admin_department_path(@department), notice: "部署「#{@department.name}」を更新しました"
        else
          @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
          @reference_departments = Department.all.order(:number)
          render :edit
        end
      else #1.update失敗の理由がその他（バリデーションエラー等）の場合
        @departments = Department.where(ancestry: nil).or(Department.where("ancestry not like?", "%/%")).order(:number)
        @reference_departments = Department.all.order(:number)
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
