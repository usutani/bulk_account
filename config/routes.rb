Rails.application.routes.draw do
  resources :bulk_accounts, only: %i[ new create ]
  root to: redirect("/bulk_accounts/new")
end
