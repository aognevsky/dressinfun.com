class UsersController < ApplicationController
	# Cut out all non-logged-in queries to Edit and Update pages
	before_filter :login_required, :only => [:edit, :update]
	
	# Users list at /users
	def index
		@users = User.find(:all)
	end
	
	# User profile at /users/:login
	def show
		# No such user
		if ! @user = User.find_by_login(params[:id])
			flash[:error] = "Извините, пользователь «<strong>#{params[:id]}</strong>» не найден."
			redirect_to users_path
		else
			# Show this user
			@friendship = Friendship.new
		end			
	end
	

	# User sign up at /signup
  def new
    @user = User.new
  end

	
	# User profile
	def edit
		@user = User.find(current_user)
	end
	
	
	def update
		@user = User.find_by_login(current_user.login)
		
		if @user.update_attributes(params[:user])
		    	flash[:notice] = 'Ваш профиль был успешно обновлен.'
			    redirect_to(settings_path)
			
			  else
			flash[:error] = "Обновить профиль не удалось. Видимо, что-то случилось."
			  	render :action => "edit" 
			  end		
	end
 

  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Спасибо за регистрацию! Мы отправили Вам письмо с кодом активации."
    else
      flash[:error]  = "Регистрация не удалась. Видимо, что-то случилось."
      render :action => 'new'
    end
  end
end
