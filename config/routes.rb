Webcal::Application.routes.draw do
  root "static_pages#index"
  resources :calendars do
    resources :events
  end
end
