enable :sessions

get '/hello' do
	@message = params[:message] if !params[:message].nil?
	erb :"static/hello"
end

post '/signup' do
	user = User.new(params[:user])
	if user.save
		@message = "Thank you for signing up! You may now login!"
	else
		@message = "There was a problem while signing up. Please check your details and try again. Passwords must be between 6 - 20 characters long."
	end
	redirect "/hello?message=#{@message}"
end

post '/login' do
	
	@user = User.authenticate(params[:user][:email], params[:user][:password])
	if @user == nil
		@message = "There was a problem logging in. Try again."
		redirect "/hello?message=#{@message}"
	else
		@message = "Logged in!"
		session[:user_id] = @user.id
		redirect "/?message=#{@message}"
	end
end

post '/logout' do
	session[:user_id] = nil
	redirect to '/'
end

get '/users/:id' do |id|
	@user = User.find(id)
	erb :"static/user"
end