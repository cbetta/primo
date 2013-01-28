# Written by Cristiano Betta <cbetta@gmail.com>
# PostgreSQL + Rspec + More to come

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

# Setup Rspec
gem_group :development, :test do
  gem "rspec-rails"
end

run "rm -rf test"
run "rm -rf autotest"

# Specify generators
application <<-EOF
    config.generators do |g|
      g.test_framework      :rspec
    end
EOF

# Finalize setup
run "bundle"
run "rails generate rspec:install"
