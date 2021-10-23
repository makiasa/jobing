class WorksController < ApplicationController
  def show
    @year = AnnualYear.find(params[:annual_year_id])
    @work = Work.find(params[:id])
  end
end
