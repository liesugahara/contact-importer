Rails.application.routes.draw do
  resources :uploads do
    collection { post :csv_file }
  end

  resources :contacts do
    collection { get :not_imported }
    collection { get :imported}
  end

  get 'home/index'
  devise_for :users
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
