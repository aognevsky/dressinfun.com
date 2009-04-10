class Friendship < ActiveRecord::Base
	belongs_to	:user

  belongs_to	:friend, 
							:class_name => "User", 
							:foreign_key => "user_id"

  belongs_to	:fan, 
							:class_name => "User", 
							:foreign_key => "friend_id"
  
end
