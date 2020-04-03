Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/domain_naming_registries", to: "domain_naming_registries#create"
  get "/domain_naming_registries", to: "domain_naming_registries#find_domain_by"
end
