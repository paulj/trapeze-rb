require 'rubygems'
require 'sinatra'
require 'json'

get '/github' do
  puts "This is a GitHub hook!"
  "This is a GitHub hook!"
end

post '/github' do
  push = JSON.parse(params[:payload])
  puts "I got some JSON: #{push.inspect}"
  "I got some JSON: #{push.inspect}"
end
