class PagesController < ApplicationController
  def home
    @annual_year = AnnualYear.find(1)
    @user = User.find(current_user.id)
    @department = current_user.department
    @works = current_user.department.works
    @september_works = @works.where(period:9)
    @october_works = @works.where(period:10)
    @november_works = @works.where(period:11)
    @irregular_works = @works.where(period: nil)
  end
  
  def index
  end
end