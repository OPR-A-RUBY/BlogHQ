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

before do
	@post_all = Postme.order(:id).reverse_order
end

get '/' do
    erb :index
end

get '/posts' do
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

get '/comm/:post_id' do
	# И так, мы имеем url, переданный из postview.erb при нажати кнопки 'Ответить'
	# причём, после последнего слеша уазано слово (здесь у нас это цыфра, id записи), 
	# полученное из конкретной записи, в которой находилась нажатая гномом ссылка  
	# в отображении postview.erb

	# Эту важную для нас цыфру мы выделим из всего url через параметр :post_id
	# выраженное здесь как символ. 

	# Параметр из url-строки (post_id) присваиваем переменной внутри этоого метода
	post_id_var = params[:post_id]

	# Запрашиваем из БД ту запись, у которой id = номеру, полученному из postview.erb 
	# через url (см. выше)
	@main_post = Postme.find(post_id_var)

	erb :comments
end

post '/comm/:post_id' do
	
	post_id_var = params[:post_id]
	@main_post = Postme.find(post_id_var)

	@mes = Message.new params[:message]
	if @mes.save
 		erb "Спасибо, Ваш коментарий записан."
	else
		@error = @c.errors.full_messages.first
	    erb :comments
	end 

	erb :comments
	
end

get '/contacts' do
    erb :contacts
end