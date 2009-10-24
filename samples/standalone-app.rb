require 'rubygems'
require 'sinatra'
require 'trapeze'

set :server, 'trapeze'
set :host, 'localhost'
set :port, '*.localhost.*./.#'

get '/' do
  "Hello World"
end

get '/ruby/' do
  "Hello World"
end
