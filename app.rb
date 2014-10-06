require 'rubygems'
require 'sinatra'

# Settings

Tilt.register Tilt::ERBTemplate, 'html.erb'
set :views, settings.root + '/app/views'
set :bind, "0.0.0.0"

# Routes

get "/" do
  erb :index
end

get "/css.css" do
  scss :css, style: :expanded
end

get '/test' do
  erb :test, { :layout => :'constitucion/layout.html' }
end

get '/toast' do
  erb :toast
end

get '/argentina' do
  erb :"constitucion/argentina", { :layout => :'constitucion/layout.html' }
end
