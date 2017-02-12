Rails.application.routes.draw do
  resources :assets, path: "asset", only: [:new, :create, :index] #-> url.com/asset/new

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
  match 'assets/get/:id' => 'assets#get', :via => [:get], :as => 'download'

end
