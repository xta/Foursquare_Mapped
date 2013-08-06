class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :checkins

	def self.from_omniauth(auth)
	  if where(auth.slice(:provider, :uid)).any?
	  	where(auth.slice(:provider, :uid)).first
	  else
	  	new_user = new

	  	new_user.provider 	= auth.provider
	    new_user.uid 				= auth.uid
	    new_user.token 			= auth.credentials.token
	    new_user.email 			= auth.info.email
	    new_user.first_name = auth.info.first_name
	    new_user.last_name 	= auth.info.last_name
	  	new_user.save

	  	new_user
	  end
	end

	def password_required?
	  super && provider.blank?
	end

end
