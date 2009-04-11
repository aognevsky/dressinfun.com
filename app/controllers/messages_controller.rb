class MessagesController < ApplicationController
  def index
  end

  def inbox
  end

  def outbox
  end

  def new 
		render :text => params[:id]
  end

	def write
		render :text => 'Page is not here'
	end

end
