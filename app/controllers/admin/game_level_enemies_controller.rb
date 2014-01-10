class Admin::GameLevelEnemiesController < Admin::BaseController

  before_filter :except => [:index, :create, :new] do
    @sys_enemy = SysEnemy.find(params[:id])
  end

  def index
    @game_level = SysGameLevel.find(params[:sys_game_level_id])
    @enemies = @game_level.enemies
  end

  def new
    @game_level = SysGameLevel.find(params[:sys_game_level_id])
    @enemy = @game_level.enemies.new
  end

  def create
    @game_level = SysGameLevel.find(params[:sys_game_level_id])
    @enemy = @game_level.enemies.new(params[:game_level_enemy].permit!)
    if @enemy.save
      redirect_to(admin_sys_game_level_game_level_enemies_path(@game_level), :notice => 'SysEnemy 创建成功。')
    else
      render :action => :new
    end
  end

  def update
    if @sys_enemy.update_attributes(params[:sys_enemy].permit!)
      redirect_to(admin_sys_enemies_path, :notice => 'SysEnemy 更新成功。')
    else
      render :action => :new
    end
  end

  def destroy
    @sys_enemy = SysEnemy.find(params[:id])
    @sys_enemy.destroy
    redirect_to(admin_sys_enemies_path,:notice => "删除成功。")
  end
end
