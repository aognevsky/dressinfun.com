ActionController::Routing::Routes.draw do |map|
	map.root :controller => 'home'
	
	map.resources	:users, :friendships,	:messages
  map.resource :session

#	map.write '/messages/write/:id', :controller => 'messages', :action => 'new'
	map.settings '/settings', :controller => 'users', :action => 'edit'
	
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'

	map.follow '/users/:id/follow', :controller => 'friendships', :action => 'follow'
	map.unfollow '/users/:id/unfollow', :controller => 'friendships', :action => 'unfollow'
	
	map.users '/users/:id', :controller => 'users', :action => 'show'
	
	# map.resources :users do |users|
	#     users.resources :messages, :collection => { :delete_selected => :post }
	#   end
	

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
