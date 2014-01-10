class BattlesController < ApplicationController
  def new
    sys_game_level = SysGameLevel.find(params[:level_id])
    @battle = Battle.new(:user => @current_user, :sys_game_level => sys_game_level)
    if @battle.save
      @battle.result!
      redirect_to root_path, :notice => '开展成功'
    else
      redirect_to root_path, :notice => '开展失败'
    end
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