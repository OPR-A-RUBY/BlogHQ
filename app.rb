#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:posts.db'

class Postme < ActiveRecord::Base
end

get '/' do
    erb "Hello Opr"
end

get '/newpost' do
	erb :newpost
end

