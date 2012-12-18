require File.dirname(__FILE__) + '/boot/boot.rb'

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path 'app/assets/scripts'
  environment.append_path 'app/assets/stylesheets'
  environment.append_path 'app/assets/mages'

  run environment
end

run MyNewApp::Routes
