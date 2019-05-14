class GroupEventsController < ApplicationController
  def index
    @events = GroupEvent.active
  end
  
  def show
    @group_event = GroupEvent.find(params[:id]) 
  end
  
  def new 
    @group_event = GroupEvent.new                
  end
  
  def create
    event_params = check_params(group_event_params)
    event = GroupEvent.create(event_params)
    if params[:group_event][:published] == "true" && valid_params?(event_params)
      event.update(published: true)
      flash[:success] = "The event was published"
    else
      flash[:warning] = "The event was saved but is not published"
    end
    redirect_to group_event_path(event)
  end
  
  def update
    event_params = check_params(group_event_params)
    event = GroupEvent.find(params[:id])
    event.update(event_params)
    if params[:group_event][:published] == "true" && valid_params?(event_params)
      event.update(published: true)
      flash[:success] = "The event was published"
    else
      event.update(published: false)
      flash[:warning] = "The event was updated but is not published"
    end
    redirect_to group_event_path(event)
  end
  
  def destroy 
    event = GroupEvent.find(params[:id])
    event.update(deleted: true)
    redirect_to group_events_path
  end
  
  private
  
  def group_event_params
    params.require(:group_event).permit(:name, :location, :start_date, 
      :end_date, :duration)
  end
  
  def check_params(event)
    if event[:start_date].blank? && !event[:duration].blank?
      event[:start_date] = event[:end_date].to_date - event[:duration].to_i.days
    end
    if event[:end_date].blank? && !event[:duration].blank?
      event[:end_date] = event[:start_date].to_date + event[:duration].to_i.days
    end
    if !event[:end_date].blank? && event[:duration].blank? || 
       !event[:start_date].blank? && !event[:end_date].blank? && !event[:duration].blank?
      event[:duration] = (event[:end_date].to_date - event[:start_date].to_date).to_i
    end
    if !event[:start_date].blank? && !event[:end_date].blank? &&
       event[:end_date].to_date < event[:start_date].to_date
       event[:start_date] = ""
       event[:end_date] = ""
       event[:duration] = ""
    end
    event
  end
  
  def valid_params?(event)
    !(event[:name].blank? ||
      event[:location].blank? || 
      event[:start_date].blank? ||
     (event[:end_date].blank? || event[:duration].blank?))
  end
end
