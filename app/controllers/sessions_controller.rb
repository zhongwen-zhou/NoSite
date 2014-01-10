class SessionsController < ApplicationController
  def new
    session["user_return_to"] = request.referrer
  end

  def create
    @user = User.authorize!(params)
    if @user
      session[:current_user_id] = @user.id
      redirect_to root_path
    else
      render :action => :new
    end
  end

end