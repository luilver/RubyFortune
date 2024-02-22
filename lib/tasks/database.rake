namespace :db do
  desc 'drop your database'
  task :drop do
    require 'bundler'
    Bundler.require
    require './config/environment'

    FileUtils.rm("db/#{ENV.fetch('RACK_ENV', nil)}.db")
  end

  desc 'migrate your database'
  task :migrate do
    require 'bundler'
    Bundler.require
    require './config/environment'

    ActiveRecord::MigrationContext.new('db/migrate').migrate
  end

  desc 'reset your database'
  task :reset do
    Rake::Task['db:drop'].execute
    Rake::Task['db:migrate'].execute
  end
end
