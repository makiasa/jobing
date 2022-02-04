class PagesController < ApplicationController
  def home
    if  4 <= Date.today.month && Date.today.month <= 12
      @current_fiscalyear = Date.today.year
    else
      @current_fiscalyear = Date.today.year - 1
    end
    
    @current_month = Date.today.month
    
    @login_user = User.find(current_user.id)
    
    @my_belonging_department = current_user.department
    
    @myworks = current_user.works.where(fiscalyear: @current_fiscalyear).group_by{|work| work.period}
    @irregular_myworks = @myworks[nil]
    
    @within_the_deadline_todos = current_user.todos.where("deadline >= ?", Date.today).order(:deadline)
    @overdue_todos = current_user.todos.where("deadline < ?", Date.today).order(:deadline)
   
    @my_events = current_user.events
    @todos_in_calender = current_user.todos.where("status = ? or status = ?" , 0 , 1 ).group_by{|todo| todo.deadline}
  end
  
  def index
  end
end