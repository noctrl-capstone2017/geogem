source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'bcrypt', '3.1.11'
gem 'bootstrap-sass', '3.3.6'
gem 'bootstrap-will_paginate'
gem 'will_paginate'
gem 'rails', '~> 5.0.1'
gem 'faker',  '1.6.6'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'prawn'
gem 'prawn-table'
gem 'time_difference'
gem 'chartkick'
gem 'groupdate'
gem 'yaml_db' #exports entire DB to yaml via console command '$ rake db:data:dump' -- Not ideal, but works! Dumps to db/data.yml.

group :development, :test do
  gem 'rails-controller-testing'
  gem 'sqlite3', '1.3.12'
  gem 'pdf-inspector', require: "pdf/inspector"
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg', '0.18.4'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]