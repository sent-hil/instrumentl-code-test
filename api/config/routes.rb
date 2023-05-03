Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # TODO: I regret call the model Resource now.
  resources(:resources, only: [:index, :show], param: :slug)

  get("query", to: "query#query")
end
