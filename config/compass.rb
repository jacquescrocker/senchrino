# This configuration file works with both the Compass command line tool and within Rails.
# Require any additional compass plugins here.

project_type = :stand_alone
project_path = PADRINO_ROOT
# Set this to the root of your project when deployed:
http_path = "/"

sass_dir = "app-styles"
css_dir = "public/stylesheets/compiled"
images_dir = "public/images"

http_images_path = "#{Settings.site_url}/images/"

sass_options = Settings.sass.to_hash

environment = PADRINO_ENV

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# load sencha themes
load File.join(PADRINO_ROOT, "app-styles/touch/themes")

