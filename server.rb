require 'sinatra'
require_relative 'config/application'

set :bind, '0.0.0.0'  # bind to all interfaces

enable :sessions

# Any classes you add to the models folder will automatically be made available in this server file

get '/' do
  redirect '/starships'
end

get '/starships' do
  # Use a custom Starship class that inherits from ActiveRecord to retrieve your database objects
  # You should be using ActiveRecord CRUD methods to aid you.
  # E.g. Planet.where(planet_type: "gas giant"), etc.
  @ships = Ship.all
  erb :'starships/index'
end

get '/starships/new' do

  erb :'starships/new'
end

post '/starships/new' do
  @name = params["name"]
  @ship_class = params["ship_class"]
  @location = params["location"]

  if @name.strip != "" && @ship_class.strip != "" && @location.strip != ""
    ship = Ship.create(
      name: @name,
      ship_class: @ship_class,
      location: @location
    )
    id = Ship.last.id
    flash[:notice] = 'You have created a starship successfully'
    redirect "/starships/#{id}"
  else
    erb :'starships/new'
  end
end

get '/starships/:id' do
  @ship = Ship.find(params["id"])
  erb :'starships/show'
end
