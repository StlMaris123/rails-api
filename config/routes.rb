Rails.application.routes.draw do
  use_doorkeeper do
    skip_controllers :applications, :authorizations, :authorized_applications
  end
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
