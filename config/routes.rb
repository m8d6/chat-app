Rails.application.routes.draw do
  # Ana sayfa ve dashboard route'ları
  root "dashboard#index"
  get "/dashboard", to: "dashboard#index", as: "dashboard"

  # Oturum işlemleri
  get "/login", to: "sessions#new", as: "new_session"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/signup", to: "users#new", as: "signup"
  post "/signup", to: "users#create"

  get "/password/reset", to: "passwords#new", as: "new_password"
  post "/password/reset", to: "passwords#create", as: "password_reset"
  get "/password/reset/:token", to: "passwords#edit", as: "edit_password"
  patch "/password/reset/:token", to: "passwords#update"

  # Üyelik sözleşmesi
  get "/terms", to: "terms#show"

  # Email doğrulama
  get "/verify_email/:token", to: "users#verify_email", as: "verify_email"
end
