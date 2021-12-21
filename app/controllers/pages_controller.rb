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
    @current_month_works = @works.where(period: @current_month)
    
    @todos = current_user.todos.where("deadline >= ?", Date.today).order(:deadline)
    @over_todos = current_user.todos.where("deadline < ?", Date.today).order(:deadline)
    @irregular_works = @works.where(period: nil)
    
    @events = Event.all
  end
  
  def index
  end
end