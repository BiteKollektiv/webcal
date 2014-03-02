class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :upload, :download, :destroy]
  include Uploader

  def show
    if params[:id].size == 13
      @calendar = Calendar.where(token_read: params[:id]).first
      @calendar.writable = false
    else
      @calendar = Calendar.where(token_write: params[:id]).first
      @calendar.writable = true
    end

    @events = @calendar.events
    @type = params[:type] ? params[:type].to_sym : :month
    @date = params[:date] ? params[:date].to_date : Time.zone.today
  end

  def new
    @calendar = Calendar.new
    @weekdays = I18n.t('date.day_names')
  end

  def upload
    allowed = ["text/calendar"]
    if file = Uploader.upload(params[:ical], allowed)
      @calendar.import(file)
      File.delete(file)
      redirect_to @calendar, notice: t('calendar.import.success')
    else
      redirect_to @calendar, notice: t('calendar.import.invalidfiletype')
    end
  end

  def download
    file = @calendar.to_ical
    send_file file, type: 'text/calendar'
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
    @weekdays = I18n.t('date.day_names')
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
      @calendar = Calendar.find_by(token_write: params[:id])
    end

    def calendar_params
      params.require(:calendar).permit(:title, :description, :token_read, :token_write, :type, :date)
    end
end
