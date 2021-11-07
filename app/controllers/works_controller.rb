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
    @workflows = @work.workflows.order(:number)
    
    @all_fiscalyears = {"R3":2021, "R2":2020, "R1/H31":2019, "H30":2018, "H29":2017}
    @works = Work.where(firstid: @work.firstid)
    
      @fiscalyear = Hash.new
      @all_fiscalyears.each do |key,val|
        if @works.find_by(fiscalyear: val) != nil
           @fiscalyear[:"#{key}"] = val
        end
      end
  end
  
  def move
    @work = Work.where(firstid: Work.find(params[:id]).firstid).find_by(fiscalyear: params[:fiscalyear])
    if @work
      redirect_to work_path(@work.id)
    else
      render :show
    end
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
