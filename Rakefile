# frozen_string_literal: true

require 'bundler/setup'
require 'fileutils'
require 'rake'
require 'rspec/core'
require 'rspec/core/rake_task'
require 'rubygems'

RSpec::Core::RakeTask.new(:spec)

desc 'load environment'
task :environment do
  ENV['RACK_ENV'] ||= 'development'
  require File.expand_path('config/environment', __dir__)
end

Rake.add_rakelib 'lib/tasks'

require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

task default: %i[rubocop spec]
