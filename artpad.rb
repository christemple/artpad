$LOAD_PATH.unshift File.expand_path('lib')
require 'sinatra'
require 'sinatra/assetpack'
require 'thin'
require 'helpers'
require 'mongo'
require 'json'
require 'securerandom'

configure do
  set :port, 3000
  set :root, File.dirname("../")
end

register Sinatra::AssetPack
assets {
  css :app, ['/css/*.css']
  js :app, ['/js/raphael*.js', '/js/*.js']
}

include Mongo
def drawings
  return @db_connection.collection('drawings') if @db_connection
  db = URI.parse('http://localhost:27017')
  @db_connection = Mongo::MongoClient.new(db.host, db.port).db('artpad')
  @db_connection.authenticate('user', 'password')
  @db_connection.collection('drawings')
end

get '/' do
  redirect "/#{SecureRandom.hex[0..5]}"
end

get '/:name' do
  erb :index
end

post '/:name' do
  drawings.update({ _id: params[:name]},{ _id: params[:name], drawing: params['data']}, { upsert: true })
end

get '/:name/json' do
  content_type :json
  drawing = drawings.find_one({_id: params[:name].to_s})
  drawing ? drawing['drawing'].to_json : '{}'
end