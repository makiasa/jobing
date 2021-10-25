class PagesController < ApplicationController
  def home
    @annual_year = AnnualYear.find(1)
    @user = User.find(current_user.id)
    @department = current_user.department
    @works = current_user.department.works
    @current_month = Date.today.month
    @last_month = @current_month - 1
    @current_month_works = @works.where(period: @current_month)
    @todos = current_user.todos
    
    @september_works = @works.where(period:9)
    @october_works = @works.where(period:10)
    @november_works = @works.where(period:11)
    @irregular_works = @works.where(period: nil)
  end
  
  def index
  end
end