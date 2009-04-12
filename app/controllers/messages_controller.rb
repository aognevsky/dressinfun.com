class MessagesController < ApplicationController
	before_filter :login_required
	
  def index
  end

	def show
		@message = Message.read(params[:id], current_user)
	end

  def new 
		@message = Message.new
		@user = User.find_by_login(params[:id])
  end

	def create
		if Message.create! :sender => current_user, :recipient => User.find(params[:message][:recipient]), :subject => params[:message][:subject], :body => params[:message][:body]
			flash[:notice] = "Сообщение было успешно отослано пользователю."
			redirect_to '/'		
		end
	end

end


#Friendship.create! :user_id => current_user.id, :friend_id => User.find_by_login(params[:id]).id
