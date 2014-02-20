class EventsController < ApplicationController
  def index
    @events = Event.all
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

    private
    
    def event_params
      params.require(:event).permit(:title, :description, :location, :starts_at, :ends_at)
    end
  end
end
