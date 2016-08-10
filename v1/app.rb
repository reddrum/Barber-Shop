#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
  db = SQLite3::Database.new 'barbershop.db'
  db.results_as_hash = true
  return db
end

configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS
      "Users"
      (
            "id" INTEGER PRIMARY KEY AUTOINCREMENT,
            "username" TEXT,
            "phone" TEXT,
            "datestamp" TEXT,
            "barber" TEXT,
            "color" TEXT
      )'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School!!!!!</a>"
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do
  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @barber = params[:barber]
  @color = params[:color]

  # @title = 'Thank you!'
  # @message = "Dear #{@username}, we'll be waiting for you at #{@datetime}, #{@color}"

  #f = File.open './public/users.txt', 'a'
  #f.write "Name: #{@name}, User: #{@username}, Phone: #{@phone}, Date&time: #{@datetime}"
  #f.close
  
  # хеш
  hh = { :username => 'Ввведите имя',
         :phone => 'Введите номер телефона', 
         :datetime => 'Введите дату и время' }

  @error = hh.select {|key,_| params[key] == ""}.values.join(", ")

  if @error != ''
    return erb :visit
  end

  db = get_db
  db.execute 'insert into
    Users
    (
      username,
      phone,
      datestamp,
      barber,
      color
    )
    values (?, ?, ?, ?, ?)', [@username, @phone, @datetime, @barber, @color]

  erb "<h2>Спасибо, вы записались!</h2>"
end

get '/showusers' do
  db = get_db

  @results = db.execute 'select * from Users order by id desc'
  
  erb :showusers
end




# get '/contacts' do
# 	erb :contacts
# end
#
# post '/contacts' do
#   @email = params[:email]
#   @text = params[:text]
#
#   @title = 'Thank you!'
#   @message = "Ваше сообщение отправлено!"
#
#  # f = File.open './public/contacts.txt', 'a'
#  # f.write "Email: #{@email}, Text: #{@text}"
#  # f.close
#   hh = { :email => 'Ввведите ваш e-mail',
#          :text => 'Введите текст', }
#
#   @error = hh.select {|key,_| params[key] == ""}.values.join(", ")
#
#   if @error != ''
#     return erb :contacts
#   end
#
#   erb :message
# end

