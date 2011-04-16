# require 'rubygems'
# require 'bundler/setup'

ENV["RAILS_ROOT"] = File.expand_path("../../../", __FILE__)
require 'heroku/rails/tasks'

# heroku needs this task or it complains
namespace :db do
  task :migrate do
  end
end

# Deploy Tasks
task :deploy =>  ["heroku:deploy"]
task :console => ["heroku:console"]
task :setup =>   ["heroku:setup"]

# Heroku Deploy Callbacks
namespace :heroku do

  # runs before each push to a particular heroku deploy environment
  task :before_each_deploy do
    puts "Uploading assets to #{@heroku_app[:env]}!"

    # grab the environment settings of the deploy environment (for s3 stuff)
    Settings.add_source!("#{Padrino.root}/config/settings/#{@heroku_app[:env]}.yml")
    Settings.reload!

    # upload everything
    Rake::Task["assets:upload"].invoke
  end

  task :after_each_deploy do
    # TODO: open up growl alert saying we're done deploying to @heroku_app[:app_name]
  end

  task :after_deploy do
    # TODO
    # clear out public/stylesheets/compiled

    # TODO
    # clear out public/javascripts/compiled

    # TODO: send alert email
    # that lists all the environments we deployed to
  end
end

namespace :assets do

  desc "Compiles all the SASS files"
  task :compile_sass => :environment do

    # regenerates SASS
    puts "Compiling SASS"
    Sass::Plugin.force_update_stylesheets
    puts "DONE!"

  end

  desc "Compiles all the Coffeee files"
  task :compile_coffee => :environment do

    coffee_root = "#{Padrino.root}/app-js/"

    Dir["#{coffee_root}**/*.coffee"].each do |file_path|
      coffee_path = file_path.sub(coffee_root, "")
      write_path = "#{Padrino.root}/public/javascripts/compiled/#{coffee_path.gsub(/\.coffee$/, '.js')}"

      puts "CoffeeScript: #{coffee_path}"
      FileUtils.mkdir_p File.dirname(write_path)
      File.open(write_path, "w+") do |f|
        f.write CoffeeScript.compile(File.read(file_path))
      end
    end

  end

  # Compiles all the static assets in the project
  desc "Compiles all the assets (SASS, CoffeeScript, etc)"
  task :compile => :environment do
    # regenerates SASS
    puts "Compiling SASS"

    # setup compass
    Compass.add_project_configuration(Padrino.root("config", "compass.rb"))
    Compass.configure_sass_plugin!
    Compass.handle_configuration_change!

    Sass::Plugin.force_update_stylesheets
    puts "DONE!"

    # regenerate coffeescripts
    puts "\nCompiling Coffee"
    Rake::Task["assets:compile_coffee"].invoke
    puts "DONE!"

    # Package up Jammit assets
    puts "\nPackaging Jammit..."
    Jammit.package!
    puts "DONE!"
  end

  # Upload all the static assets to s3
  desc "Uploads all the assets to S3"
  task :upload => :compile do
    # initialize the s3 access info from our Settings
    Jammit.upload_to_s3!({
      :bucket_name => Settings.versioned_asset_bucket,
      :access_key_id => Settings.s3.access_key_id,
      :secret_access_key => Settings.s3.secret_access_key
    })

    Rake::Task["assets:cleanup"].invoke
  end

  desc "Cleans up old asset files"
  task :cleanup => :environment do
    # backup old assets
    old_assets_dir = "#{Padrino.root}/tmp/old-assets/#{Time.now.to_i}"
    FileUtils.mkdir_p(old_assets_dir)

    # move compiled stylesheets
    compiled_stylesheets_path = "#{Padrino.root}/public/stylesheets/compiled"
    if File.exists?(compiled_stylesheets_path)
      FileUtils.mkdir_p("#{old_assets_dir}/stylesheets")
      FileUtils.mv(compiled_stylesheets_path, "#{old_assets_dir}/stylesheets/")
    end

    # move javascripts
    compiled_javascripts_path = "#{Padrino.root}/public/javascripts/compiled"
    if File.exists?(compiled_javascripts_path)
      FileUtils.mkdir_p("#{old_assets_dir}/javascripts")
      FileUtils.mv("#{Padrino.root}/public/javascripts/compiled", "#{old_assets_dir}/javascripts/")
    end

    # clean out sass-cache
    if File.exists?("#{Padrino.root}/tmp/sass-cache")
      FileUtils.rm_rf("#{Padrino.root}/tmp/sass-cache")
    end

  end
end