source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '4.2.4'

gem 'mysql2', '~> 0.3.13', group: :development
gem 'pg', group: :production

gem 'nested_form'

gem 'unicorn', group: :production

gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
# facebook
gem "koala", "~> 2.2"

gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
gem 'bootstrap-sass', '~> 3.3.5'
gem 'font-awesome-sass', '~> 4.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'rails-erd'

group :development, :test do
  gem 'rspec-rails', '~> 2.14.2'
  gem 'factory_girl_rails', '~> 4.4.1'
  # for tracking performance
  # gem 'rack-mini-profiler', require: false
  gem 'dotenv-rails'

  # for DEBUG
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'web-console', '~> 2.0'

  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-unicorn-nginx', '~> 3.2.0'
end
