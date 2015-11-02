class Favorite < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :user_id, :product_id, presence: true
	validates :user_id, uniqueness: {scope: :product_id}

	belongs_to :user
	belongs_to :product
end
