source :rubygems

# Project requirements
gem 'rake'
gem 'rack-flash'

# Component requirements
gem 'haml', ">= 3.1.0.alpha.147"
gem "sass", ">= 3.1.0.alpha.253"
gem "compass", ">= 0.11.beta.7"

# Padrino
gem 'padrino', :git => "https://github.com/padrino/padrino-framework.git"

# rack middleware that allows forcing domain
gem "rack-force_domain", :git => "http://github.com/railsjedi/rack-force_domain.git"

# rabl provides a nice templating language for api
gem "rabl"

# mongoid stuff
gem "bson", "1.2.1"
gem "bson_ext", "1.2.1"
gem "mongo", "1.2"
gem "mongoid", ">= 2.0.0"

# add coffeescript support
gem "therubyracer-heroku", :require => nil
gem "coffee-script"
gem "barista", :git => "https://github.com/Sutto/barista.git"

gem "s3", ">= 0.3.7"

# rails config
gem "rails_config", ">= 0.2.3"

# asset packaging
gem "open4"
gem "jammit-sinatra", ">= 0.6.0"
gem "jammit-s3", ">= 0.6.0"

# api helpers
gem "pusher"

gem "launchy", "= 0.3.2"
gem "heroku-rails", ">= 0.3.1"

group :development, :test do
  gem "ruby-debug19", :platforms => :mri_19
end

group :development do
  gem 'thin' # or mongrel

  gem "rack-debug"

  # setup guard
  gem "guard"

  gem "guard-coffeescript"
  gem "guard-pusher", :git => "http://github.com/railsjedi/guard-pusher.git"
  gem "guard-compass"

  gem "growl"
end

group :test do
  gem "rspec", ">= 2.5.0"
  gem 'ffaker'

  gem "autotest"

  gem "rack-test", :require => "rack/test"

  gem "remarkable_mongoid"
  gem 'capybara'
  gem 'webrat'

  gem "webmock"
  gem "vcr"
end