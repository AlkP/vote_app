Rails.application.routes.draw do
  root "pages#home"
  get "up" => "rails/health#show", as: :rails_health_check

  resources :apartments
  resources :surveys do
    resources :questions

    get "answers", to: "answers#edit"   # форма для массового ввода
    patch "answers", to: "answers#update" # массовое обновление
  end
end
