require 'sinatra/base'
require 'sinatra/json'
require 'json'
require 'pry'

class ListApp < Sinatra::Base
  set :logging, true

  DB = {}

  get '/list' do
    json(DB)
  end

  post '/list' do
  end

  patch '/list' do
  end

  delete '/list' do
  end
end

# if $0 == __FILE__
ListApp.run! if $PROGRAM_NAME == __FILE__
