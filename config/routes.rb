Rails.application.routes.draw do
   get 'login', to: 'sessions#new', as: :login
   post 'login', to: 'sessions#create'
   
   resource :registration, only: [:new, :create] do
     get :confirm
   end
   
   if Rails.env.development?
      mount LetterOpenerWeb::Engine, at: "/letter_opener"
    end
    
   root "registrations#new"
 end