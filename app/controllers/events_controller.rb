class EventsController < ApplicationController
  def index
    @events = Event.all
    @todos_in_calender = current_user.todos.where("status = ? or status = ?" , 0 , 1 )
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(event_parameter)
    if @event.save
      redirect_to events_path
      flash[:success] = "スケジュールを登録しました"
    else
      render :new
    end
  end
  
  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_parameter)
      redirect_to events_path
      flash[:success] = "スケジュールを編集しました"
    else
      render :edit
    end
  end
  
  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
    flash[:warning] = "スケジュールを削除しました"
  end

  private

  def event_parameter
    params.require(:event).permit(:title, :content, :start_time, :end_time)
  end
end
