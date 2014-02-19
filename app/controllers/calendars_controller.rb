class CalendarsController < ApplicationController
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]

  def show
    if params[:id].size == 13
      @calendar = Calendar.where(token_read: params[:id]).first
      @calendar.writable=false
    else
      @calendar = Calendar.where(token_write: params[:id]).first
      @calendar.writable=true
    end
    @events = @calendar.events 
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
<<<<<<< HEAD
<<<<<<< HEAD
      @calendar = Calendar.find_by_token(params[:token])
    end
=======
#      @calendar = Calendar.find_by_token(params[:write_token])
=======
>>>>>>> Add to_param method in calendar model, to have token in url, changed controller & views to work with token as id
      @calendar = Calendar.where("token_write = params[:token_write]")
  end
>>>>>>> Add create calendar form in homepage

    def calendar_params
      params.require(:calendar).permit(:title, :description, :token_read, :token_write)
    end
end
