SimpleShortner::Application.routes.draw do
  # Cat backbone routes that are resubmitted while using
  # pushDown:true.
  get "/show", :to => redirect("/")

  # Catch and redirect our shortlinks
  get "/:code" => "page_views#create"

  # Provide an endpoint for client-side code.
  namespace :api do
    resources :shortlinks, :only => [:create]
  end

  # Deliver the client-side app.
  root :to => "static_pages#root"
end
