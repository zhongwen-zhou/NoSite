class BattlesController < ApplicationController
  def new
    sys_game_level = SysGameLevel.find(params[:level_id])
    @battle = Battle.new(:user => @current_user, :sys_game_level => sys_game_level)
    if @battle.save
      @battle.result!
      redirect_to root_path, :notice => '开战成功'
    else
      redirect_to root_path, :notice => '开战失败'
    end
  end
end