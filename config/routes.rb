Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  
  root "quiz#explanation"

  get '/login' => "sessions#new"
  post '/login' => 'sessions#create'
  get '/logout'=> 'sessions#destroy'
  
  get "quiz/friend_list"  => "quiz#friend_list"
  get "quiz/edit"  => "quiz#edit"
  get "quiz/quiz" => "quiz#quiz"
  get "quiz/show_answer" => "quiz#show_answer"
  get "quiz/input_answer" => "quiz#input_answer"
  get "quiz/show_ranking" => "quiz#show_ranking"
  get 'quiz/ajax_get_name_array' => 'quiz#ajax_get_name_array'
  get 'quiz/ajax_set_name_link' => 'quiz#ajax_set_name_link'
  get 'quiz/ajax_reset' => 'quiz#ajax_reset'
  get 'quiz/ajax_get_content' => 'quiz#ajax_get_content'

  post "quiz/ajax_profile_save" => "quiz#ajax_profile_save"
  post "quiz/ajax_content_save" => "quiz#ajax_content_save"
  post "quiz/ajax_post_answer" => "quiz#ajax_post_answer"
end
