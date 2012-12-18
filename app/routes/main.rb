class MyNewApp::Routes

  get named(:home, '/') do
    erb :'home'
  end

end
