require 'byebug'

get '/' do
	@products = Product.all.reverse
	@message = params[:message] if !params[:message].nil?
  erb :"static/index"
end

get '/products/new' do
	@message = params[:message] if !params[:message].nil?

	if logged_in? == false
		@message = "Only logged in users can post ads. Login now!"
		erb :"static/hello"
	else
		erb :"static/new_ad"
	end
end

post '/products/new' do

	product = current_user.products.new(params[:product])

	if product.save
		redirect "/products/#{product.id}"
	else 
		@message = "There was a problem creating your ad. Make sure all fields are filled before submitting."
		redirect "/products/new?message=#{@message}"
	end
end

get '/products/:id' do |id|

	@product = Product.find(id)
	@seller = @product.user

	erb :"static/product_ad"
end

get '/products/:id/edit' do |id|
	
		@message = params[:message] if !params[:message].nil?
		@product = Product.find(id)
	if current_user.id == @product.user_id
		erb :"static/edit_ad"
	else
		redirect '/'
	end
end

post '/products/:id/update' do |id|
	@product = Product.find(id)
	@product.update(params[:product])
	if @product.save

	redirect "/products/#{@product.id}"

	else
		@message = "There was a problem updating your ad. Make sure all fields are filled before submitting."
		redirect "/products/#{id}/edit?message=#{@message}"
	end
end

post '/products/:id/delete' do |id|
	product = Product.find(id)
	product.destroy
	redirect '/'
end

get '/users/:id/products' do |id|
	@seller = User.find(id)
	@products = @seller.products.reverse

	erb :"static/list"
end
