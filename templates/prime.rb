# Setup PG
gsub_file "Gemfile", "gem 'sqlite3'", "gem 'pg'"

database_config = <<-EOF
development:
  adapter: postgresql
  encoding: unicode
  database: #{app_name}_dev

test:
  adapter: postgresql
  encoding: unicode
  database: #{app_name}_test
EOF

remove_file "config/database.yml"
file "config/database.yml", database_config
file "config/database.yml.example", database_config

# Setup HAML
gem "haml"
gem_group :development do
  gem "haml-rails"
end

remove_file "app/views/layouts/application.html.erb"
file "app/views/layouts/application.html.haml", <<-EOF
!!!
%html
  %head
    %title #{app_name.humanize}
    = stylesheet_link_tag :application, media: "all"
    = javascript_include_tag :application
    = csrf_meta_tags
  %body
    = yield
EOF

# Setup Rspec
gem_group :development, :test do
  gem "rspec-rails"
end

run "rm -rf test"
run "rm -rf autotest"

# Specify generators
application <<-EOF
    config.generators do |g|
      g.template_engine     :haml
      g.test_framework      :rspec
    end
EOF

# Finalize setup

run "bundle"
run "rails generate rspec:install"
