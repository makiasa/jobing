class PagesController < ApplicationController
  def home
    @annual_year = AnnualYear.find(1)
    @user = User.find(current_user.id)
    @department = current_user.department
    @works = current_user.works
  end
  
  def index
  end
end