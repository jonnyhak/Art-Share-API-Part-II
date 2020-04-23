Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :create, :destroy, :show, :update] do
    resources :artworks, only: :index do 
      collection do 
        get 'favorites'
      end
        
    end
    resources :comments, only: :index
    
    
  end
  resources :artworks, only: [:create, :destroy, :show, :update] do 
    patch 'favorite', :on => :member
    resources :comments, only: :index
    resources :likes, only: :index
  end
  resources :artwork_shares, only: [:create, :destroy] do
    patch 'favorite', :on => :member
  end

  resources :comments, only: [:create, :destroy] do 
    resources :likes, only: :index
  end

  resources :likes, only: [:create, :destroy]
end




# get 'users/:id', to: 'users#show'
  # get 'users', to: 'users#index'
  # get 'users/new', to: 'users#new'
  # get 'users/:id/edit', to: 'users#edit'
  # post 'users', to: 'users#create'
  # patch 'users/:id', to: 'users#update'
  # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'