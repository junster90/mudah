enable :sessions

get '/hello' do
	erb :"static/hello"
end

post '/signup' do
	user = User.new(params[:user])
	if user.save
		@message = "Thank you for signing up! You may now login!"
	else
		@message = "There was a problem while signing up. Please check your details and try again. Passwords must be between 6 - 20 characters long."
	end
	redirect '/'
end

post '/login' do
	@user = User.authenticate(params[:user][:email], params[:user][:password])
	session[:user_id] = @user.id
	redirect to '/'
end

post '/logout' do
	session[:user_id] = nil
	redirect to '/'
end

get '/users/:id' do |id|
	@user = User.find(id)
	erb :"static/user"
end