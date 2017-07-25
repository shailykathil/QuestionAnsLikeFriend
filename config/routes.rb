Rails.application.routes.draw do
  devise_for :users
  resources :users
    resources :questions do
	  resources :answers do
		    get :likes
	  end
    end
  resources :likes, only: [:create, :destroy]
  root 'questions#index'
  get "/user/notification" => "users#notification"
  get "/user/addfriend" => "users#friend"
  get "/user/accept" => "users#accept_friend"
  get "/user/delete" => "users#delete_friend"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
