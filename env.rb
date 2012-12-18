ENV["RACK_ENV"]         ||= "development"
ENV['DATABASE_URL']     ||= "postgres://postgres:postgres@localhost/#{ENV["RACK_ENV"]}"
ENV['BASE_URL']         ||= 'http://localhost:9292'
