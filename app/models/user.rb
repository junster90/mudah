class User < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	validates :full_name, :email, :password, presence: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
	validates :email, :uniqueness => {:case_sensitive => false}
	validates :password, length: { in: 6..20 }

	has_many :products, dependent: :destroy
	has_many :favorites, dependent: :destroy

	def self.authenticate(email,password)
		user = User.where(email: email).find_by(password: password)
		return user
  end

end
