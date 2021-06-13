class AdminUser < ApplicationRecord
	devise :database_authenticatable, 
		:recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

	with_options presence: true do
		validates :email
		validates :provider
		validates :uid, uniqueness: { scope: :provider }
	end

	def password_required? 
		return false if provider.present?
		super
	end
	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do | user |
			user.email = auth.info.email
		end
	end

end
