class EventsController < ApplicationController
  before_action :set_calendar, only: [:index, :show]
  attr_accessor :calendar

  def index
    @events = @calendar.events
#    Calendar.set_calendar_permissions(params[:calendar_id])
  end
  
  def show
    @event = @calendar.events.find(params[:id])
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

  def set_calendar
    @calendar = Calendar.find_by(params[:token_read])
    @calendar = Calendar.set_permissions(params[:calendar_id])
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :location, :starts_at, :ends_at)
  end
end

