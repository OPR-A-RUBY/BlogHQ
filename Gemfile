source "https://rubygems.org"

# Указанные ниже GEM-мы будут установлены на хостинг во время разворачивания 
# приложения на серевере. 
gem "sinatra"
gem "sqlite3"
gem "activerecord"
gem "sinatra-activerecord"
gem "sinatra-contrib"

# А gem "tux" - будет установлен только здесь и только для разработки и отладки 
# программы, т.е. в боевом режиме он будет пропущен, 
# т.к. он в режиме PRODUCTION не нужен.
# Это становиться очень полезным, когда этих гемов становится много.
group :development do 
	gem "tux"
end
