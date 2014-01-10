class Admin::SysEnemiesController < Admin::BaseController

  before_filter :except => [:index, :create, :new] do
    @sys_enemy = SysEnemy.find(params[:id])
  end

  def index
    @sys_enemys = SysEnemy.all
  end

  def new
    @sys_enemy = SysEnemy.new
  end

  def create
    @sys_enemy = SysEnemy.new(params[:sys_enemy].permit!)
    if @sys_enemy.save
      redirect_to(admin_sys_enemies_path, :notice => 'SysEnemy 创建成功。')
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
