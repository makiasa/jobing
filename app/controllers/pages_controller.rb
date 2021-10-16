class PagesController < ApplicationController
  def home
    @year = Year.find(1)
    @user = User.find(current_user.id)
    @department = Department.find(current_user.department_id)
    @work = Work.find_by(user_id: current_user.id)
  end
  
  def index
  end
end