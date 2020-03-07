#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

get '/' do
    erb "Hello Opr"
end

get '/newpost' do
	erb :newpost
end
