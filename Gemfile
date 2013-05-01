ruby '1.9.3'
source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'pg'
gem 'haml'
gem 'sorcery'
gem 'haml'
gem 'jquery-rails'
gem 'simple_form'
gem 'newrelic_rpm'

# Attempt to get better stack traces on Heroku when PSQL times out
gem 'rack-timeout'

group :development do
  gem 'better_errors'
  gem 'pry-rails'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'haml-rails'
  gem "zurb-foundation", ">= 4.0.9"
end

group :tools do
  gem 'rb-inotify', :require => false
  gem 'guard-test'
  gem 'guard-livereload'
end

group :test do
  gem "factory_girl_rails"
  gem "database_cleaner"
  gem "capybara"
  gem "capybara-webkit"
  gem 'pry-rails'
end
