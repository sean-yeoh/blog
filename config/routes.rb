Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admins
  as :admin do
    get '/settings' => 'devise/registrations#edit', :as => 'admin_settings'
    put '/settings' => 'devise/registrations#update', :as => 'update_admin_settings'
  end
  resources :posts, path: "/blog"
  resources :todos do
    member do
      patch "done"
      patch "undo"
    end
  end
  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
