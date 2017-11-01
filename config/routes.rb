Rails.application.routes.draw do
  resources :messages
  resources :conversations
  resources :sharedfolders
  resources :uploadfiles
  resources :folders
  devise_for :users
  root :to => "home#index"
  match "uploadfiles/get/:id" => "uploadfiles#get", :as => "download", via: [:post, :get]
  match "browse/:folder_id" => "home#browse", :as => "browse", via: [:post, :get]
  match "browse/:folder_id/new_folder" => "folders#new", :as => "new_sub_folder", via: [:post, :get]
  match "browse/:folder_id/new_file" => "uploadfiles#new", :as => "new_sub_file", via: [:post, :get]
  match "browse/:id/rename" => "folders#edit", :as => "rename_folder", via: [:post, :get]
  match "browse/:id/share" => "sharedfolders#new", :as => "share_folder", via: [:post, :get]
  get "/users" => "users#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
