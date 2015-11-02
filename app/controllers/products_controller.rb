require 'byebug'

get '/' do
	@products = Product.all.reverse
  erb :"static/index"
end

get '/products/new' do
	if logged_in? == false
		@message = "Only logged in users can post ads. Login now!"
		erb :"static/hello"
	else
		erb :"static/new_ad"
	end
end

post '/products/new' do
	product = Product.new(name: params[:product][:name], description: params[:product][:description], price: params[:product][:price], user_id: current_user.id)
	product.save

	redirect "/products/#{product.id}"
end

get '/products/:id' do |id|
	@product = Product.find(id)
	@seller = User.find(@product.user_id)
	erb :"static/product_ad"
end

get '/products/:id/edit' do |id|
	@product = Product.find(id)
	erb :"static/edit_ad"
end

post '/products/:id/update' do |id|
	@product = Product.find(id)
	@product.update(name: params[:product][:name], description: params[:product][:description], price: params[:product][:price])
	@product.save

	redirect "/products/#{@product.id}"
end

post '/products/:id/delete' do |id|
	product = Product.find(id)
	product.destroy
	redirect '/'
end

get '/users/:id/products' do |id|
	@products = Product.where(user_id: id).reverse
	@seller = User.find(id)
	erb :"static/list"
end
