DEWTwitter::Application.routes.draw do
  resources :tweets
  match "user"      => "tweets#read_message"
  match "read_text" => "tweets#read_text"
  match "update"    => "tweets#update_status"
  
end
