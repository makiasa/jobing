class PagesController < ApplicationController
  def home
    if  4 <= Date.today.month && Date.today.month <= 12
      @current_fiscalyear = Date.today.year
    else
      @current_fiscalyear = Date.today.year - 1
    end
    
    @user = User.find(current_user.id)
    @department = current_user.department
    @works = current_user.works.where(fiscalyear: @current_fiscalyear)
    @current_month = Date.today.month
    @last_month = @current_month - 1
    @current_month_works = @works.where(period: @current_month)
    @todos = current_user.todos
    
    @irregular_works = @works.where(period: nil)
  end
  
  def index
  end
end