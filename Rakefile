task :default => :'test:all'

desc "Open an irb session with the same environment as the app"
task :console do
  sh "irb -r ./boot/boot"
end

namespace :bundler do
  task :setup do
    require 'rubygems'
    require 'bundler/setup'
  end
end

desc "For preloading the env on every other task"
task :environment, [:env] => 'bundler:setup' do |cmd, args|
  ENV["RACK_ENV"] = args[:env] || ENV["RACK_ENV"] || "development"
  require "./boot/boot"
end
 
namespace :db do
  desc "Run database migrations"
  task :migrate, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
 
    require 'sequel/extensions/migration'
    Sequel::Migrator.apply(DB, "./db/migrate")
  end
 
  desc "Rollback the database"
  task :rollback, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
 
    require 'sequel/extensions/migration'
    version = (row = DB[:schema_info].first) ? row[:version] : nil
    Sequel::Migrator.apply(DB, "./db/migrate", version - 1)
  end
 
  desc "Nuke the database (drop all tables)"
  task :nuke, :env do |cmd, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)
    DB.tables.each do |table|
      begin
        DB.run("DROP TABLE #{table} CASCADE")
      rescue
        puts "Your database doesn't support DROP TABLE CASCADE, try something else to nuke it!"
      end
    end
  end
 
  desc "Reset the database"
  task :reset, [:env] => [:nuke, :migrate]

  desc "Seed discount types to database"
  task :seed, :env do |cmg, args|
    env = args[:env] || "development"
    Rake::Task['environment'].invoke(env)

    require './db/seeds'
  end

  desc "Create empty migration file"
  task :new_migration do
    time = Time.now.strftime('%Y%m%d%H%M')
    file_path = "./db/migrate/#{time}_create_foo.rb"
    sh "touch #{file_path}"
  end
end
