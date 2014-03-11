class EventsController < ApplicationController
  before_action :set_calendar, only: [:index, :show, :new, :create, :edit, :update]
  attr_accessor :calendar

  def index
    @events = @calendar.events
#    Calendar.set_calendar_permissions(params[:calendar_id])
  end
  
  def show
    @event = @calendar.events.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = @calendar.events.build(event_params)
    if @event.save
      flash[:success] = "Event Created."
      redirect_to [@calendar, @event]
    else
      render 'new'
    end
  end

  def edit
    @event = @calendar.events.find(params[:id])
  end

  def update
    @event = @calendar.events.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:success] = "Event Updated."
      redirect_to [@calendar, @event]
    else
      render 'edit'
    end
  end

  def destroy
  end

  def set_calendar
    @calendar = Calendar.find_by(params[:token_read])
    @calendar = Calendar.set_permissions(params[:calendar_id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :starts_at, :ends_at)
  end
end

