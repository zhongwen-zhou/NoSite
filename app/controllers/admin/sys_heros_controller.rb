class Admin::SysHerosController < Admin::BaseController

  before_filter :except => [:index, :create, :new] do
    @sys_hero = SysHero.find(params[:id])
  end

  def index
    @sys_heros = SysHero.all
  end

  def new
    @sys_hero = SysHero.new
  end

  def create
    @sys_hero = SysHero.new(params[:sys_hero].permit!)
    if @sys_hero.save
      redirect_to(admin_sys_heros_path, :notice => 'SysHero 创建成功。')
    else
      render :action => :new
    end
  end

  def update
    if @sys_hero.update_attributes(params[:sys_hero].permit!)
      redirect_to(admin_sys_heros_path, :notice => 'SysHero 更新成功。')
    else
      render :action => :new
    end
  end

  def destroy
    @sys_hero = SysHero.find(params[:id])
    @sys_hero.destroy
    redirect_to(admin_sys_heros_path,:notice => "删除成功。")
  end
end
