# From http://stackoverflow.com/a/12109098 & modified
module Tokenable
  extend ActiveSupport::Concern

  included do
    before_validation :generate_read_token, :generate_write_token
  end

  protected

  def generate_read_token
    self.token_read = loop do
      break random_token unless token_exists?(random_token)
    end
  end

  def generate_write_token
    self.token_write = loop do
      break random_token unless token_exists?(random_token)
    end
  end

  def token_exists?(token)
    self.class.exists?(token_read: token) && self.class.exists?(token_write: token)
  end

  def random_token
    SecureRandom.urlsafe_base64(nil, false)
  end
end
