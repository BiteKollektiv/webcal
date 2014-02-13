class Calendar < ActiveRecord::Base
  include Tokenable

  validates :token_read, :token_write, presence: true, on: :create
  validates :token_read, :token_write, uniqueness: true, on: :create
  has_many :events
end
