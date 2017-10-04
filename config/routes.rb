Rails.application.routes.draw do
  resources :messages
  resources :conversations
  resources :sharedfolders
  resources :uploadfiles
  resources :folders
  devise_for :users
  root :to => "home#index"
  match "uploadfiles/get/:id" => "uploadfiles#get", :as => "download", via: [:post, :get]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
