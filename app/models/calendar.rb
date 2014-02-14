class Calendar < ActiveRecord::Base
  include Tokenable

  validates :token_read, :token_write, presence: true, on: :create
  validates :token_read, :token_write, uniqueness: true, on: :create
  has_many :events

  def month
    month_start = DateTime.now.beginning_of_month.beginning_of_week
    month_end = DateTime.now.end_of_month.end_of_week

    events.where('starts_at >= ?', month_start).
      where('starts_at <= ?', month_end)
  end

  def today
    day_start = DateTime.now.beginning_of_day
    day_end = DateTime.now.end_of_day

    events.where('starts_at >= ?', day_start).
      where('starts_at <= ?', day_end)
  end
end
