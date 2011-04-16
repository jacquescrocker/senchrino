::PADRINO_ENV = "development"
::PADRINO_ROOT = File.dirname(__FILE__) unless defined?(PADRINO_ROOT)

guard 'compass' do
  watch(/^app-styles\/(.*)\.s[ac]ss/)
end

guard "coffeescript", :input => "app-js", :output => "public/javascripts/compiled"

require 'rails_config'
RailsConfig.load_and_set_settings(
  File.join(PADRINO_ROOT, "config", "settings.yml").to_s,
  File.join(PADRINO_ROOT, "config", "settings", "#{PADRINO_ENV}.yml").to_s,
  File.join(PADRINO_ROOT, "config", "environments", "#{PADRINO_ENV}.yml").to_s
)

if Settings.pusher.enabled
  guard 'pusher', :app_id => Settings.pusher.app_id, :key => Settings.pusher.key, :secret => Settings.pusher.secret do
    watch(%r{^app-js/.+\.coffee})
    watch(%r{^app-js/.+\.jst})
    watch(%r{^app-styles/.+\.sass})
  end
end