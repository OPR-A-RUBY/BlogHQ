#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:posts.db'

class Postme < ActiveRecord::Base
end

class Message < ActiveRecord::Base
end

get '/' do
    erb :postsview
end

get '/newpost' do
	@pos = Postme.new
	erb :newpost
end

post '/newpost' do

  	@pos = Postme.new params[:postme]		# Создать новый пост, у которого будут 
  										    # параметы как у объекта postme.
  	# Они будут заполняться сразу в форме newpost.erb и передаваться сюда хешем.

  	if @pos.save					# Записать данные в таблицу БД
  									# Здесь происходит валидация данных
  	# настройка которых происходит при описании class Postme (см. выше)
    
	    erb "Спасибо, Ваш пост записан."

	else

		@error = @c.errors.full_messages.first
	    erb :newpost
	
	end 
end