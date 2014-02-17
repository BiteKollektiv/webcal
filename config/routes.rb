Webcal::Application.routes.draw do
  get '/:locale' =>  "static_pages#index"
  root to: "static_pages#index"
  scope "/:locale", locale: /en|es|de/ do
#  scope "/:locale" do
    resources :calendars, param: :token do
      resources :events
    end
  end
end
