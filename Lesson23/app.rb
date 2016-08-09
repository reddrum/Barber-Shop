#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

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
  @name = params[:name]
  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @color = params[:color]

  @title = 'Thank you!'
  @message = "Dear #{@username}, we'll be waiting for you at #{@datetime}, #{@color}"

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

  erb :message
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
  @email = params[:email]
  @text = params[:text]

  @title = 'Thank you!'
  @message = "Ваше сообщение отправлено!"

 # f = File.open './public/contacts.txt', 'a'
 # f.write "Email: #{@email}, Text: #{@text}"
 # f.close
  hh = { :email => 'Ввведите ваш e-mail',
         :text => 'Введите текст', }

  @error = hh.select {|key,_| params[key] == ""}.values.join(", ")

  if @error != ''
    return erb :contacts
  end

  erb :message
end
