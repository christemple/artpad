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
  set :mongodb, 'http://localhost:27017/artpad'
end

configure :production do
  set :mongodb, ENV['MONGOHQ_URL']
end

register Sinatra::AssetPack
assets {
  css :app, ['/css/*.css']
  js :app, ['/js/raphael*.js', '/js/*.js']
}

include Mongo
def drawings
  return @db_connection.collection('drawings') if @db_connection
  db = URI.parse(settings.mongodb)
  db_name = db.path.gsub(/^\//, '')
  @db_connection = Mongo::MongoClient.new(db.host, db.port).db(db_name)
  @db_connection.authenticate('user', 'passw0rd')
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