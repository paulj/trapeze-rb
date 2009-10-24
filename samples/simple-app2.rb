require 'rubygems'
require 'sinatra'
  
get '/' do
  "Hello Different World"
end

get '/ruby/' do
  "Hello world from /ruby/"
end
