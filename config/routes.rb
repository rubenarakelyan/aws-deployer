Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"
  get "/auth/:provider/callback", to: "sessions#create"
  delete "/auth/logout", to: "sessions#destroy"
  get "/auth/unauthorised", to: "pages#unauthorised"
end
