source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.6'
# Use SCSS for stylesheets
gem 'sass-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Bundling of JavaScript assets
gem 'jsbundling-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Use AWS S3 for ActiveStorage
gem 'aws-sdk-s3', require: false

# Pagination
gem 'kaminari'

# User authentication
gem 'devise', '~> 4.8.1'

# Tagging
gem 'gutentag', '~> 2.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Browser detection
gem 'browser', '~> 4.2'

# Running other processes
gem 'open3', '~> 0.1.1'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem 'spring'

  # Help to get rid of N+1 queries and unused eager loading
  gem 'bullet'

  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'reek', require: false
  gem 'rails_best_practices', require: false
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
end
