# From http://stackoverflow.com/a/12109098
module Tokenable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_read_token, :generate_write_token
  end

  protected

  def generate_read_token
    self.token_read = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(token_read: random_token)
    end
  end

  def generate_write_token
    self.token_write = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.exists?(token_write: random_token)
    end
  end
end
