class WorksController < ApplicationController
  def new
    @work = Work.new
    @workflows = @work.workflows.build
  end
  
  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end
  
  def show
    @work = Work.find(params[:id])
    @works = Work.where(firstid: @work.firstid)
    @workflows = @work.workflows.order(:number)
    @fiscalyears = {"R3":2021, "R2":2020, "R1/H31":2019, "H30":2018, "H29":2017}
  end
  
  def edit
    @work = Work.find(params[:id])
  end
  
  def update
    @work = Work.find(params[:id])
    @work.update(work_params)
    
    redirect_to  work_path(params[:id])
  end
  
  private
  def work_params
    params.require(:work).permit(:name,:period,:summary,:task,
                                workflows_attributes: [:id,:number,:content,:note,:filepath,:_destroy])
  end
end
