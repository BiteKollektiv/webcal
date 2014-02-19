class Calendar < ActiveRecord::Base
  include Tokenable

  validates :token_read, :token_write, presence: true, on: :create
  validates :token_read, :token_write, uniqueness: true, on: :create
  has_many :events


  attr_accessor :changeable
  alias :changeable? :changeable

  def month
    month_start = Time.zone.now.beginning_of_month.beginning_of_week
    month_end = Time.zone.now.end_of_month.end_of_week

    events_between(month_start, month_end)
  end

  def week
    week_start = Time.zone.now.beginning_of_week
    week_end = Time.zone.now.end_of_week

    events_between(week_start, week_end)

  def to_param  # overridden
    token_read
  end

  def today
    day_start = Time.zone.now.beginning_of_day
    day_end = Time.zone.now.end_of_day

    events_between(day_start, day_end)
  end

  def self.find_by_token(token)
    if calendar = Calendar.find_by(token_write: token)
      calendar.changeable = true
    elsif calendar = Calendar.find_by(token_read: token)
      calendar.changeable = false
    end
    calendar
  end

    protected

    def events_between(range_start, range_end)
      events.where('starts_at >= ?', range_start).
        where('starts_at <= ?', range_end)
    end
end
