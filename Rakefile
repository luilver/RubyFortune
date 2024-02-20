# frozen_string_literal: true

require 'bundler/setup'
require 'fileutils'
require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'rubygems'

RSpec::Core::RakeTask.new(:spec)

task :environment do
  ENV['RACK_ENV'] ||= 'development'
  require File.expand_path('config/environment', __dir__)
end

Rake.add_rakelib 'lib/tasks'

task default: %i[spec]
