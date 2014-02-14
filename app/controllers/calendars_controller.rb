class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  def show
    if @calendar
      @events = @calendar.events
      flash.now[:notice] = "changeable: #{@calendar.changeable?}"
    else
      redirect_to root_path, notice: t('calendar.notfound')
    end
  end

  def new
    @calendar = Calendar.new
  end

  def create
    @calendar = Calendar.new(calendar_params)

    if @calendar.save
      redirect_to @calendar, notice: t('calendar.created')
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @calendar.update(calendar_params)
      redirect_to @calendar, notice: t('calendar.updated')
    else
      render action: 'edit'
    end
  end

  def destroy
    @calendar.destroy
    redirect_to new_calendar_path, notice: t('calendar.destroyed')
  end

    private

    def set_calendar
      @calendar = Calendar.find_by_token(params[:token])
    end

    def calendar_params
      params.require(:calendar).permit(:title, :description)
    end
end
