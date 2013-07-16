$LOAD_PATH.unshift File.expand_path('lib')
require 'sinatra'
require 'sinatra/assetpack'
require 'thin'
require 'helpers'

configure do
  set :port, 3000
  set :root, File.dirname("../")
end

register Sinatra::AssetPack
assets {
  css :app, ['/css/*.css']
  js :app, ['/js/raphael.js', '/js/*.js']
}

get '/' do
  erb :index
end