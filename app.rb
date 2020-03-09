#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, 'sqlite3:posts.db'

class Postme < ActiveRecord::Base
	validates :content, presence: true, length: { minimum: 5 } 
	validates :autor, presence: true 	
end

class Message < ActiveRecord::Base
	validates :content, presence: true, length: { minimum: 5 } 
	validates :autor, presence: true
	validates :post_id, presence: true 	
end

class Letter < ActiveRecord::Base
	validates :content, presence: true, length: { minimum: 5 } 
	validates :autor, presence: true	
end

before do
	@post_all = Postme.order(:id).reverse_order

end

get '/' do			# ---------------- / M A I N --------------------------------
    erb :index
end

get '/posts' do		# ---------------- / P O S T S ------------------------------
    max_post = 2	### ЗДЕСЬ НЕДОРАБОТКА ###
    @mes_by = []
    0.upto(max_post) do |item|
    	colvo = 0 
    	Message.all.each do |message_item|
    		colvo += 1 if message_item.post_id.to_i == item 
    	end
    	@mes_by << colvo
    end	
    erb :postsview
end

get '/newpost' do	# ---------------- / N E W P O S T S ------------------------
	@pos = Postme.new
	erb :newpost
end

post '/newpost' do	# ---------------- / N E W P O S T S ------------------POST--

  	@pos = Postme.new params[:postme]		# Создать новый пост, у которого будут 
  										    # параметы как у объекта postme.
  	# Они будут заполняться сразу в форме newpost.erb и передаваться сюда хешем.

  	if @pos.save					# Записать данные в таблицу БД
  									# Здесь происходит валидация данных
  	# настройка которых происходит при описании class Postme (см. выше)
    
	    erb "Спасибо, Ваш пост записан."

	else

		@error = @pos.errors.full_messages.first
	    erb :newpost
	 
	end 
end

get '/comm/:post_id' do	# ---------------- / C O M / ... ------------------------
	# И так, мы имеем url, переданный из postview.erb при нажати кнопки 'Коментарий'
	# причём, после последнего слеша уазано слово (здесь у нас это цыфра = id записи), 
	# полученное из конкретной записи, в которой находилась нажатая гномом ссылка  
	# в отображении postview.erb 
	# Таких ссылок мого они похожи друг на друга, но каждая имеет свой уникальный url

	# Эту важную для нас цыфру мы выделим из всего url через параметр :post_id
	# выраженное здесь как символ. 

	# Параметр из url-строки (post_id) присваиваем переменной внутри этоого метода
	post_id_var = params[:post_id]

	# Запрашиваем из БД ту запись, у которой id = номеру, полученному из postview.erb 
	# через url (см. выше)
	@main_post = Postme.find(post_id_var)
	# эти две строки преобразованы в одну в методе ost '/comm/:post_id' см ниже (м1)

	# ВАРИАНИ_1 Нагрузка на сервер = получаем только нужные записи
	@all_coments_to_main_post = Message.where("post_id = ?", 
		params[:post_id]).reverse_order
	# и в браузере останется только вывести их все в таблицу

	erb :comments
end

post '/comm/:post_id' do	# ---------------- / C O M / ... ---------------POST-----

	@main_post = Postme.find(params[:post_id])
									# Об этом написано выше (м1)

	@mes = Message.new params[:message]	# Создаём объект, даные внести с формы
	@mes.post_id = @main_post.id 	# Добавляем недостающий параметр post_id из
	# сообщения, которое выбрано для создания кометария к нему 

	if !@mes.save		# Внести данные в БД с проверкой (validates) см. в верху
 		@error = @mes.errors.full_messages.first
		# если валидация даёт ошибку - сосздать переменную ошибки и внести в неё
		# первое сообщение из всех имеющихся после валидации.	    
	end 

	# Здесь получаем только нужные записи,
	@all_coments_to_main_post = Message.where("post_id = ?", params[:post_id]).reverse_order
	# а в браузере останется только вывести их все в таблицу

	erb :comments	
end

get '/contacts' do	# ---------------- / C O N T A C T S ------------------------
    erb :contacts
end

post '/contacts' do	# ---------------- / C O N T A C T S -----------------POST---
	@let = Letter.new params[:letter]	# Создаём объект, даные внести с формы
	@let.old    = '0'		# Письмо не старое
	@let.ansver = '0'		# Ответа на него небыло

	if !@let.save		# Внести данные в БД с проверкой (validates) см. в верху
 		@error = @let.errors.full_messages.first
		# если валидация даёт ошибку - сосздать переменную ошибки и внести в неё
		# первое сообщение из всех имеющихся после валидации.	    
	end 
    erb "<b>OPR:</b> It is page of /contacts for runing post-method"
end