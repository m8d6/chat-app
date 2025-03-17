Rails.application.routes.draw do
   resource :registration, only: [ :new, :create ]
   root "registrations#new"
end
