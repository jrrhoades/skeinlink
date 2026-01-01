source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'  # Or whatever exact patch your ruby:3.3-slim image uses (check with ruby --version)

gem 'rails', '~> 7.0'  # Allows latest 7.0.x patches for security
gem 'mysql2'
gem 'puma', '~> 5.6'
gem 'jbuilder', '~> 2.7'

# Use Active Storage image variants
gem 'image_processing', '~> 1.12'
gem 'active_storage_validations'
gem 'activerecord-nulldb-adapter'
gem 'acts-as-taggable-on', '~> 12.0'  # Latest; supports modern Rails/Ruby
gem 'addressable'
gem 'audited'
gem 'aws-sdk-s3', require: false
gem 'devise'
gem 'exception_notification'
gem 'kaminari'
gem 'mini_racer'
gem 'pundit'
gem 'ransack'
gem 'redcarpet'
gem 'sprockets-rails'  # Keep if using Sprockets

group :development, :test do
  gem 'amazing_print'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-byebug'
end

group :development do
  gem 'ed25519'
  gem 'bcrypt_pbkdf'
  gem 'web-console', '>= 3.3.0'
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-controller-testing'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'simplecov', require: false
  gem 'webdrivers'
end
