class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user].permit!)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to(root_path, :notice => 'User 创建成功。')
    else
      render :action => :new
    end    
  end
end
