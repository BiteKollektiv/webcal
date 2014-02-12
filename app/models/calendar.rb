class Calendar < ActiveRecord::Base
  validates :token_read, :token_write, presence: true
  validates :token_read, :token_write, uniqueness: true
  has_many :events
end
