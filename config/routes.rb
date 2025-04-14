Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]

  resource :registration, only: [ :new, :create, :show ] do
    get :confirm
  end

  resource :onboarding, only: %i[ show update ], controller: "onboarding"

  get "dashboard", to: "dashboard#index", as: :dashboard

  if Rails.env.development?
     mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root "registrations#new"
end
