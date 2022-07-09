Rails.application.routes.draw do
  resources :bulk_accounts, only: %i[ new create ]
  namespace :bulk_accounts do
    resource :group, only: :create
  end
  root to: redirect("/bulk_accounts/new")
end
