SenchaApp.helpers do
  def javascripts(name)
    name = name.to_s.to_sym
    if Settings.package_assets
      javascript_include_tag "http://#{Settings.versioned_asset_bucket}.s3.amazonaws.com#{Jammit.asset_url(name, :js)}"
    else
      include_javascripts name
    end
  end

  def stylesheets(name)
    name = name.to_s.to_sym
    if Settings.package_assets
      stylesheet_link_tag "http://#{Settings.versioned_asset_bucket}.s3.amazonaws.com#{Jammit.asset_url(name, :css)}"
    else
      include_stylesheets name
    end
  end
end