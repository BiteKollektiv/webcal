class EventsController < ApplicationController
  attr_accessor :events 

  def index
#    @events = Calendar.find_by(params[:token_read]).events
    calendar_events
    @calendar = Calendar.find_by(params[:token_read])
    set_calendar_permissions

  end
  
  def show
    @event = Calendar.find_by(params[:token_read]).events.find(params[:id])
  end

  def new
  end

  def edit

  end

  def update
  end

  def create

  end
  def destroy
  end

  def calendar_events
    @events = Calendar.find_by(params[:token_read]).events
  end

  private

  def set_calendar_permissions
    if params[:calendar_id].size == 13
      @calendar.writable = false
    else
      @calendar.writable = true
    end
  end
  
  def event_params
    params.require(:event).permit(:title, :description, :location, :starts_at, :ends_at)
  end
end

