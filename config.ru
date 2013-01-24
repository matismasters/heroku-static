require 'bundler'
Bundler.require(:default)

require 'thin'
require 'sprockets'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'scripts'
  environment.append_path 'stylesheets'
  environment.append_path 'images'

  run environment
end

use Rack::Static, :urls => [""], :root => './html/', :index => 'index.html'
run lambda{ |env| [ 404, { 'Content-Type'  => 'text/html' }, ['404 - page not found'] ] }
