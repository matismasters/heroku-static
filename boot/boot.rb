require_relative "../env"
begin
  require_relative "../env.local"
rescue LoadError
end

require 'bundler'
Bundler.require(:default)

# Sequel initialization.
DB = Sequel.connect(ENV["DATABASE_URL"])
Sequel::Model.raise_on_save_failure = false

require 'logger'
DB.loggers << Logger.new(STDOUT).tap{|logger| logger.formatter = proc{|severity, datetime, progname, msg| "#{msg}\n"}}

module MyNewApp
  module Helpers
  end

  class Routes < Sinatra::Application
    set :root, File.dirname(__FILE__) + "/../"
    set :views, File.join("app", "views")
    set :environment, ENV["RACK_ENV"]
    set :show_exceptions, true

    use Rack::Session::Cookie, key: "MyNewApp", secret: "p27msr0v1e0l9e3z"
    use Rack::MethodOverride

    register Sinatra::NamedRoutes
    register Sinatra::Namespace

    helpers Sinatra::NamedRoutes::Helpers
    helpers Helpers
  end
end

# Sort to ensure same order in all environments
Dir["./app/models/**/*.rb"].sort.each  { |rb| require rb }
Dir["./app/routes/**/*.rb"].sort.each  { |rb| require rb }
Dir["./app/helpers/**/*.rb"].sort.each { |rb| require rb }
