Rails.application.routes.draw do
  resources :quests, only: [ :index, :create, :update, :destroy ]
  get "up" => "rails/health#show", as: :rails_health_check
  get "/brag" => "brag#index", as: :brag

  root "quests#index"
  match "*path", to: redirect("/quests"), via: :all
end
