require 'byebug'

get '/users/:id/wishlist' do |id|
	@user = User.find(id)
	@favorites = Favorite.where(user_id: id)
	erb :"/static/favorites"
end

post '/users/:user_id/wishlist/add/:product_id' do |user_id, product_id|

	favorite = Favorite.new(user_id: user_id, product_id: product_id)
	favorite.save

	redirect "/users/#{user_id}/wishlist"
end

post '/users/:user_id/wishlist/delete/:product_id' do |user_id, product_id|

	favorite = Favorite.where(user_id: user_id, product_id: product_id)

	favorite.first.destroy

	redirect "/users/#{user_id}/wishlist"
end