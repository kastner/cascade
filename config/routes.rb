ActionController::Routing::Routes.draw do |map|
  map.resources :categories, :articles
  map.root :controller => "articles", :action => "new"
end
