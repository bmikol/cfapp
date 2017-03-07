Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}
  resources :users
  resources :products
  resources :orders, only: [:index, :show, :create, :destroy]

  get 'about' =>					'static_pages#about'
  get 'contact' =>				'static_pages#contact'
  get 'landing_page' =>		'static_pages#landing_page'

  root 'static_pages#index'

  post 'static_pages/thank_you'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
