class Event < ActiveRecord::Base
  belongs_to :calendar
  validates :title,     presence: true
  validates :starts_at, presence: true
  validates :ends_at,   presence: true
  validates_presence_of :calendar
end
