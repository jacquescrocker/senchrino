# Defines our constants
PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..')) unless defined?(PADRINO_ROOT)

# Load Bundler
require 'rubygems'
require 'bundler'
# Only have default and environment gems
Bundler.setup(:default, PADRINO_ENV.to_sym)
# Only require default and environment gems
Bundler.require(:default, PADRINO_ENV.to_sym)
puts "=> Located #{Padrino.bundle} Gemfile for #{Padrino.env}"

# configure settings
RailsConfig.load_and_set_settings(
  File.join(PADRINO_ROOT.to_s, "config", "settings.yml").to_s,
  File.join(PADRINO_ROOT.to_s, "config", "settings", "#{PADRINO_ENV}.yml").to_s,
  File.join(PADRINO_ROOT.to_s, "config", "environments", "#{PADRINO_ENV}.yml").to_s
)

# add initializers
Padrino.custom_dependencies("#{Padrino.root}/config/initializers/*.rb")

# setup Barista
Barista.configure do |c|
  c.root = File.join(PADRINO_ROOT, "app-js")
  c.output_root = File.join(PADRINO_ROOT, "public", "javascripts", "compiled")
end

##
# Add your before load hooks here
#
Padrino.before_load do
end

##
# Add your after load hooks here
#
Padrino.after_load do
  def Settings.versioned_asset_bucket
    "#{Settings.s3.asset_bucket_prefix}-#{Settings.version}"
  end

  ::RAILS_ENV = PADRINO_ENV unless defined?(::RAILS_ENV) # jammit 0.6.0 workaround
  Jammit.load_configuration("#{Padrino.root}/config/assets.yml")
end

Padrino.load!
