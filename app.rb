require 'sinatra'

set :bind, "0.0.0.0"

get "/" do
  erb :index
end

get "/css.css" do
  scss :css, style: :expanded
end

get '/hi' do
  "<html>Hello World!</html>"
end

get "/dashboard" do
  "DASHBOARD!"
end
