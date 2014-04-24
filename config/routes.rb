SimpleShortner::Application.routes.draw do
  # Catch and redirect our shortlinks
  get "/:code" => "page_views#create"

  # A show page for link clickthrough information.
  resources :shortlinks, :only => [:show]

  # Provide an endpoint for client-side code.
  namespace :api do
    resources :target_urls, :only => [:create]
  end

  # Deliver the client-side app.
  root :to => "static_pages#root"
end
