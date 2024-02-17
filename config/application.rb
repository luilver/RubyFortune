# frozen_string_literal: true

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'api'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'boot'
Bundler.require :default, ENV.fetch('RACK_ENV', 'development')

require 'active_record'
Dir[File.expand_path('../app/**/*.rb', __dir__)].each { |f| require f }

begin
  yaml = 'config/database.yml'
  if File.exist?(yaml)
    require 'erb'
    config = HashWithIndifferentAccess.new(
      YAML.safe_load(ERB.new(IO.read(yaml)).result, aliases: true)
    )
  elsif ENV['DATABASE']
    nil
  else
    raise "Could not load database configuration. No such file - #{yaml}"
  end
rescue Psych::SyntaxError => e
  raise "YAML syntax error occurred while parsing #{paths['config/database'].first}. " \
        'Please note that YAML must be consistently indented using spaces. Tabs are not allowed. ' \
        "Error: #{e.message}"
end

env = ENV['RACK_ENV'] || 'development'
adapter = config[env][:adapter]
database = config[env][:database]
db_options = { adapter: adapter, database: database }
ActiveRecord::Base.establish_connection(db_options)
