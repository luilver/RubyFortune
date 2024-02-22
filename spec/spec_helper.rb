# frozen_string_literal: true

require 'rubygems'

ENV['RACK_ENV'] ||= 'test'

require 'rack/test'

require File.expand_path('../config/environment', __dir__)

# Initialize db
`rake db:reset`

Dir[File.expand_path('factories/*.rb', __dir__)].each { |f| require f }

require 'simplecov'

SimpleCov.minimum_coverage 85
SimpleCov.start do
  add_filter 'config'
  add_filter 'spec'
  add_filter 'vendor'
end

RSpec.configure do |config|
  config.color = true
  config.formatter = :documentation

  config.mock_with :rspec
  config.expect_with :rspec
  config.raise_errors_for_deprecations!

  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
