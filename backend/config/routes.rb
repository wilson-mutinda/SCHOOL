Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      # streams
      post 'create_stream', to: 'streams#create_stream'
      get 'single_stream/:slug', to: 'streams#single_stream'
      get 'all_streams', to: 'streams#all_streams'
      patch 'update_stream/:slug', to: 'streams#update_stream'
      delete 'delete_stream/:slug', to: 'streams#delete_stream'
      get 'restore_stream/:slug', to: 'streams#restore_stream'

      # levels
      post 'create_level', to: 'levels#create_level'
      get 'single_level/:slug', to: 'levels#single_level'
      get 'all_levels', to: 'levels#all_levels'
      patch 'update_level/:slug', to: 'levels#update_level'
      delete 'delete_level/:slug', to: 'levels#delete_level'
      get 'restore_level/:slug', to: 'levels#restore_level'

      # subjects
      post 'create_subject', to: 'subjects#create_subject'
      get 'single_subject/:slug', to: 'subjects#single_subject'
      get 'all_subjects', to: 'subjects#all_subjects'
      patch 'update_subject/:slug', to: 'subjects#update_subject'
      delete 'delete_subject/:slug', to: 'subjects#delete_subject'
      get 'restore_subject/:slug', to: 'subjects#restore_subject'

      # users
      post 'create_user', to: 'users#create_user'
      get 'single_user/:slug', to: 'users#single_user'
      get 'all_users', to: 'users#all_users'
      patch 'update_user/:slug', to: 'users#update_user'
      delete 'delete_user/:slug', to: 'users#delete_user'
      get 'restore_user/:id', to: 'users#restore_user'
    end
  end
end
