$LOAD_PATH.unshift File.expand_path('lib')
require 'sinatra'
require 'sinatra/assetpack'
require 'thin'
require 'helpers'
require 'mongo'
require 'json'

configure do
  set :port, 3000
  set :root, File.dirname("../")
end

include Mongo

def drawings
  return @db_connection.collection('drawings') if @db_connection
  db = URI.parse('http://localhost:27017')
  @db_connection = Mongo::MongoClient.new(db.host, db.port).db('artpad')
  @db_connection.authenticate('user', 'password')
  @db_connection.collection('drawings')
end

register Sinatra::AssetPack
assets {
  css :app, ['/css/*.css']
  js :app, ['/js/raphael*.js', '/js/*.js']
}

get '/' do
  erb :index
end

post '/' do
  drawings.update({ _id: "test"},{ drawing: params['data']}, { upsert: true })
end

get '/json' do
  content_type :json
  drawings.find_one({_id: 'test'})['drawing'].to_json
end