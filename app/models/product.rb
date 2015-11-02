class Product < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :name, :description, :price, :user_id, presence: true

	belongs_to :user
end
