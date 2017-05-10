Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}, controllers: { registrations: 'user_registrations' }
  resources :users
  resources :products do
    resources :comments
  end
  resources :orders, only: [:index, :show, :create, :destroy]

  get 'about'         =>	'static_pages#about'
  get 'contact'       =>  'static_pages#contact'
  get 'landing_page'  =>	'static_pages#landing_page'
  get 'home'          =>  'static_pages#home'

  root 'static_pages#landing_page'

  post 'thank_you'    =>  'static_pages#thank_you'
  post 'payments/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
