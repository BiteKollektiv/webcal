class EventsController < ApplicationController
#  attr_accessor  :find_calendar_events

  def index
#    @events = find_calendar_events
    @events = Calendar.find_by(params[:token_read]).events
    @calendar = Calendar.find_by(params[:token_read])
    if params[:calendar_id].size == 13
      @calendar.writable = false
    else
      @calendar.writable = true
    end
  end
  
  def show
    @event = Calendar.find_by(params[:token_read]).events.find(params[:id])

  end

  def new
    @event = Event.new
  end

  def edit

  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: t('event.updated')
    else
      render action: 'edit'
    end
  end

  def create
    @event.Event.new(event_params)
    if @event.save
      redirect_to @event
    else
      render action: 'new'
    end

    def destroy
      @event.destroy
      redirect_to new_event_path, notice: t('event.destroyed')
    end

    def self.find_calendar_events
debugger
      Calendar.find_by(params[:token_read]).events
    end

    def find_calendar_event
      @event = Calendar.find_by(params[:token_read]).events.find(params[:id])
    end
  

    private
  
    def event_params
      params.require(:event).permit(:title, :description, :location, :starts_at, :ends_at)
    end
  end
end
