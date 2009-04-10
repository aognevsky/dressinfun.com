class FriendshipsController < ApplicationController
  def index
  	render :text => "Здесь ни-че-го нет."
	end

	def follow
		# If this is not current_user's profile page
		if current_user.login != params[:id]
			# If the user havent been already followed
			if ! current_user.friends.include? (User.find_by_login(params[:id]))
				Friendship.create! :user_id => current_user.id, :friend_id => User.find_by_login(params[:id]).id
				
				flash[:notice] = "Пользователь добавлен в список Ваших друзей."
				redirect_to user_path(params[:id])		
			else
				render :text => "Вы не можете добавить этого пользователя дважды!"
			end
		else
			render :text => "Вы не можете дружить сам с собой!"
		end
	end


	def unfollow
		f = Friendship.delete_all "user_id = #{current_user.id} and friend_id = #{User.find_by_login(params[:id]).id}"
		
		flash[:notice] = "Congrats, you deleted this piece of shit as friend"
		redirect_to user_path(params[:id])		
	end
end
