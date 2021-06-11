class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def google_oauth2
		admin_user = AdminUser.from_omniauth(request.env["omniauth.auth"])

		if admin_user.persisted?
			flash.notice = "Signed in!"
			sign_in_and_redirect admin_user
		else
			flash.notice = "We couldn't sign you in because: " + admin_user.errors.full_message
			redirect_to new_admin_user_session_url
		end
	end
end
