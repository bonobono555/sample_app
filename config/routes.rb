Rails.application.routes.draw do
  # WEB
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help', as: 'helpp' # asでhepp_pathという名前に変更できる
  get  '/about',   to: 'static_pages#about'
  get  '/contract', to: 'static_pages#contract'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users

  # API
  namespace :api, format: "json" do
    resources :products do
      collection do
        get 'search'
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'application#hello'

end
