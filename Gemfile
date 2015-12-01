source 'https://rubygems.org'

ruby "2.1.3"
gem 'rails', '~> 4.1.8'
gem 'bootstrap-sass'
gem "paperclip"
gem 'aws-sdk', '< 2.0'
gem "twitter"
gem "haml-rails"
gem 'pry'

gem 'omniauth-twitter', github: "arunagw/omniauth-twitter", ref: "81bf3ec0f51804d35fbc4d8f8d658e944bff6abd"
gem 'rack-attack'

group :development, :test do
  gem 'rspec-rails'
  # gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
end

gem 'pg', '0.17.1'
gem 'rails_12factor', group: :production
gem 'acts-as-taggable-on', '~> 3.4'
gem "nilify_blanks"
