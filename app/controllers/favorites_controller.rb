get '/users/:id/wishlist' do |id|
	@user = User.find(id)
	@favorites = Favorite.where(user_id: id)
	erb :"/static/favorites"
end