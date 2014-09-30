require 'sinatra'

set :bind, "0.0.0.0"

get "/" do
  "index"
end

get '/hi' do
  "<html>Hello World!</html>"
end

get "/dashboard" do
  "DASHBOARD!"
end
