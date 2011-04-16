config_file = Padrino.root("config", "mongoid.yml")
if File.exists?(config_file)
  settings = YAML.load(ERB.new(File.read(config_file)).result)[Padrino.env.to_s]
  ::Mongoid.from_hash(settings) if settings.present?
end