Rails.application.routes.draw do
   get "login", to: "sessions#new", as: :login
   post "login", to: "sessions#create"
   delete "logout", to: "sessions#destroy", as: :logout

   resource :registration, only: [ :new, :create ] do
     get :confirm
   end

   resource :onboarding, only: [ :show, :update ], controller: "onboarding"

   get "dashboard", to: "dashboard#index", as: :dashboard

   if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: "/letter_opener"
   end

   root "registrations#new"
 end
