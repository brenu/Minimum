Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  resource :session
  resources :passwords, param: :token
  resource :registration, only: [:new, :create]

  resources :blogs, only: [:show] do
    # get ":id", to: "blogs#show", as: :blogs

    resources :posts, only: [:index], shallow: true

    # get ":blog_id/posts/new", to: "posts#new", as: :new_post
    # post ":blog_id/posts/create", to: "posts#create", as: :create_post
    # get ":blog_id/posts/:post_id/edit", to: "posts#edit", as: :edit_post
    # put ":blog_id/posts/:post_id/update", to: "posts#update", as: :update_post
    # delete ":blog_id/posts/:post_id/destroy", to: "posts#destroy", as: :destroy_post
  end

  resources :posts, except: [:index] do
    resources :comments, only: [:create, :destroy], shallow: true
  end
  

  root "blogs#index"
end
