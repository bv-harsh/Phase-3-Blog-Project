Rails.application.routes.draw do
	devise_for :users
	get 'home/index'
	root to: "home#index"
	get '/users/sign_in', to: "users#index"

	resources :users do
		resources :articles
	end
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
