Rails.application.routes.draw do
  devise_for :users

  resources :posts do 
  	member do
  		get 'like',to: 'posts#like',as: 'like_post'
  		get 'unlike',to: 'posts#unlike',as: 'unlike_post'
  	end
  end

  get ':username/follow', to: 'posts#follow',as: 'follow_user'
  get ':username/unfollow', to: 'posts#unfollow',as: 'unfollow_user'

  get 'pages/index'
  root 'pages#index'
  
end
