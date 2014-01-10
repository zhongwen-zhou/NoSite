class Admin::SysGameLevelsController < Admin::BaseController

  before_filter :except => [:index, :create, :new] do
    @sys_game_level = SysGameLevel.find(params[:id])
  end

  def index
    @sys_game_levels = SysGameLevel.all
  end

  def new
    @sys_game_level = SysGameLevel.new
  end

  def create
    @sys_game_level = SysGameLevel.new(params[:sys_game_level].permit!)
    if @sys_game_level.save
      redirect_to(admin_sys_game_levels_path, :notice => 'SysGameLevel 创建成功。')
    else
      render :action => :new
    end
  end

  def update
    if @sys_game_level.update_attributes(params[:sys_game_level].permit!)
      redirect_to(admin_sys_game_levels_path, :notice => 'SysGameLevel 更新成功。')
    else
      render :action => :new
    end
  end

  def destroy
    @sys_game_level = SysGameLevel.find(params[:id])
    @sys_game_level.destroy
    redirect_to(admin_sys_game_levels_path,:notice => "删除成功。")
  end
end
