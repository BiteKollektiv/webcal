source 'https://rubygems.org'
ruby File.read(".ruby-version").strip.split("-").first
gem 'rails', '4.0.2'

# Database gems
gem 'pg'

# JS / CSS
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0' # Compress JS
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-timepicker-addon-rails'

gem 'turbolinks' # Faster links

gem 'rails-i18n', '~> 4.0.0' # import standard translations

group :test, :development do
  gem 'rspec-rails'
  gem 'capybara', '1.1.4'
  gem 'guard-rspec', require: false
  gem 'factory_girl'
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
  gem 'pry-debugger'
  gem 'i18n-tasks', '~> 0.2.10' # Gem for testing i18n
end

group :development do
  gem 'figaro'
  gem 'rails-erd'
  gem 'better_errors'
  gem 'binding_of_caller'
end

# run bundle exec rake doc:rails to generate api doc at doc/api
group :doc do
  gem 'sdoc', require: false
end
