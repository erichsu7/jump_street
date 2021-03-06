Rails.application.routes.draw do
  root to: "agents#random_agent"

  resources :agents do
    resources :uploaded_transactions
  end

  namespace :uploaded_transactions do
    resources :bulk_uploads, only: [:new, :create]
  end
end
