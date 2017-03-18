require 'sinatra/base'
require 'sinatra/json'
require 'json'
require 'pry'
require 'yaml'

class ListApp < Sinatra::Base
  set :logging, true
  set :method_override, true

  get '/' do
    @db = read_database
    erb :home
  end

  post '/' do
    db = read_database
    db['data'].push(params['note'])
    update_database(db)
    # binding.pry
    redirect '/'
  end

  delete '/' do
    db = read_database
    db['data'].pop
    update_database(db)
    redirect '/'
  end

  def read_database
    YAML.load_file('db.yml')
  end

  def update_database(db)
    File.open('db.yml', 'w') do |f|
      YAML.dump(db, f)
    end
  end
end

# if $0 == __FILE__
ListApp.run! if $PROGRAM_NAME == __FILE__
