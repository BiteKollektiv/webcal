class Calendar < ActiveRecord::Base
  include Tokenable

  validates :token_read, :token_write, presence: true, on: :create
  validates :token_read, :token_write, uniqueness: true, on: :create
  has_many :events

  def today
    day_start = DateTime.now.beginning_of_day
    day_end = DateTime.now.end_of_day

    events.where('ends_at > ?', day_start).
      where('starts_at < ?', day_end)
  end
end
