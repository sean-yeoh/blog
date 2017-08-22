Rails.application.routes.draw do
  get 'todos/index'

  get 'todos/new'

  get 'todos/edit'

  get 'todos/_form'

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admins
  resources :posts, path: "/blog"
  resources :todos
  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
