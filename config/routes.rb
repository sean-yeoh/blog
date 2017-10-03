Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admins
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
