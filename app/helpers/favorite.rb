helpers do
	
	def favorited?(product)
		exist = Favorite.where(user_id: current_user.id, product_id: product).first
		if exist == nil
			false
		else
			true
		end
	end
end