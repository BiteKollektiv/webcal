Webcal::Application.routes.draw do
  get "/:locale" =>  "static_pages#index"
  root to: "static_pages#index"

  scope "/:locale", locale: /en|es|de/ do
    resources :calendars do
      post "upload", on: :member
      resources :events
    end
  end
end
