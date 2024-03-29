source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.4'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# add rspec for unit testing
gem "rspec-rails", "~> 5.0"

# add bootstrap for styling
gem 'bootstrap', '~> 5.0.0.beta2'

# add jquery as a bootstrap dependency
gem 'jquery-rails'

# add devise for user authentication
gem "devise", "~> 4.7"

# add rolify and cancancan to manage user roles (e.g. admin vs customer)
gem "rolify", "~> 5.3"
gem "cancancan", "~> 3.2"

# add AWS S3 bucket
gem "aws-sdk-s3", "~> 1.91"

# add stripe for payments
gem "stripe", "~> 5.30"

# add ultrahook for webhook endpoints
gem "ultrahook", "~> 1.0"

# add 12factor so that Heroku doesn't break when logging out of an account. This is a solution suggest in 
# https://stackoverflow.com/questions/23073737/sign-out-not-working-on-heroku-using-devise-gem-and-rails-4
gem 'rails_12factor', group: :production
