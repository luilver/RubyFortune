# frozen_string_literal: true

require 'bundler/setup'
require 'rake'
require 'rubygems'

task :environment do
  ENV['RACK_ENV'] ||= 'development'
  require File.expand_path('config/environment', __dir__)
end

task routes: :environment do
  RubyForms::API.routes.each do |route|
    method = route.request_method.ljust(10)
    path = route.origin
    puts "     #{method} #{path}"
  end
end

namespace :db do
  desc 'migrate your database'
  task :migrate do
    require 'bundler'
    Bundler.require
    require './config/environment'

    ActiveRecord::MigrationContext.new('db/migrate').migrate
  end
end
