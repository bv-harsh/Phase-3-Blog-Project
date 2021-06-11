Rails.application.routes.draw do
 	devise_config = ActiveAdmin::Devise.config
  devise_config[:controllers][:omniauth_callbacks] = 'omniauth_callbacks'
  devise_for :admin_users, devise_config

  ActiveAdmin.routes(self)
	devise_for :users
	get 'home/index'
	root to: "home#index"
	get '/users/sign_in', to: "users#index"

	resources :users do
		resources :articles
	end
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
