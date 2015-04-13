require 'rubygems'
require 'sinatra'
require 'nokogiri'
require 'open-uri'

# Settings

configure do
  set :protection, except: [:frame_options]
end

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

get '/test/?' do
  erb :test, :layout => false
end

get '/toast' do
  erb :toast
end

get '/argentina/?' do
  erb :"constitucion/argentina/index", { :layout => :'constitucion/layout.html' }
end

get'/argentina/embed/?' do
  url = "http://constitucion.al/argentina/" # Cual es la URL?
  data = Nokogiri::HTML(open(url), nil, 'UTF-8') # Parsear documento con Nokogiri
  data.search('//ul').remove # Remover el tag <ul>
  data.search('//button').remove # Remover el tag <button>
  data.search('//header').remove # Remover el tag <header>
  art = "." + params[:art] # Leer el parametro "art" de la URL

  @articulo = data.css(art) # Poner todo junto en @articulo

  erb :"constitucion/argentina/embed", :layout => false
end
