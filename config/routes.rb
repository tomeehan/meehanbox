Rails.application.routes.draw do
  
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    resources :folders
    resources :assets, path: "asset", only: [:new, :create, :index, :destroy] #-> url.com/asset/new

    devise_for :users
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root 'home#index'
    match 'assets/get/:id' => 'assets#get', :via => [:get], :as => 'download'
    match "browse/:folder_id" => "home#browse", :via => [:get] , :as => "browse"
    match "browse/:folder_id/new_folder" => "folders#new", :via => [:get], :as => "new_sub_folder"
    match "browse/:folder_id/new_file" => "assets#new", :via => [:get], :as => "new_sub_file"
    match "browse/:folder_id/rename" => "folders#edit", :via => [:get], :as => "rename_folder"
  end

  match '*path', to: redirect("/#{I18n.default_locale}/%{path}"), :via => [:get]
  match '', to: redirect("/#{I18n.default_locale}"), :via => [:get]
end
