class PagesController < ApplicationController
  def home
    @year = Year.find(1)
    @user = User.find(1)
    @department = Department.find(1)
    @work = Work.find(1)
  end
end
