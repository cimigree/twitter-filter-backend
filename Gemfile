source "https://rubygems.org"

gem 'sinatra', '2.0.2'
gem 'activerecord'
gem 'rake'
gem 'sinatra-cross_origin'

gem 'twitter'

gem 'dotenv'

gem 'puma'
gem 'rack-conneg'

gem 'rufus-scheduler'

group :development, :test do
    # Use SQLite for ActiveRecord
  gem 'sqlite3'
end

group :production do
  # Use Postgresql for ActiveRecord
  gem 'pg'
end