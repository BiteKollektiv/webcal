class Calendar < ActiveRecord::Base
  include Tokenable
  validates :token_read, :token_write, presence: true, on: :create
  validates :token_read, :token_write, uniqueness: true, on: :create
  has_many :events
  attr_accessor :writable
  alias :writable? :writable
  scope :by_token, ->(token_write) { where(token_write: token_write).first }

  def to_param  # overridden
    token_write
  end

  def month
    month_start = Time.zone.now.beginning_of_month.beginning_of_week
    month_end = Time.zone.now.end_of_month.end_of_week

    events_between(month_start, month_end)
  end

  def week
    week_start = Time.zone.now.beginning_of_week
    week_end = Time.zone.now.end_of_week

    events_between(week_start, week_end)
  end
  def today
    day_start = Time.zone.now.beginning_of_day
    day_end = Time.zone.now.end_of_day

    events_between(day_start, day_end)
  end

  def import(file)
    importer = CalendarImporter.new(self, file)
    importer.import
  end

  def self.set_permissions(token)
    if token.size == 13
      calendar = Calendar.find_by_token_read(token)
      calendar.writable = false
    else
      calendar = Calendar.find_by_token_write(token)
      calendar.writable = true
    end
    calendar
  end


  def events_by_date(date)
    day_start = date.beginning_of_day
    day_end = date.end_of_day

    events_between(day_start, day_end)
  end

    protected

    def events_between(range_start, range_end)
      events.where('starts_at >= ?', range_start).
        where('starts_at <= ?', range_end)
    end
end
