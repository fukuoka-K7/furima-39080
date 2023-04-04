Rails.application.routes.draw do
  get 'posts', to: 'items#index'
end
