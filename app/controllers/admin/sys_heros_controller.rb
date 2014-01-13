class Admin::SysHerosController < Admin::BaseController

  before_filter do
    @sys_meta_hero = SysMetaHero.find(params[:sys_meta_hero_id])
  end

  def index
    @sys_heros = @sys_meta_hero.sys_heros
  end

  def new
    @sys_hero = SysHero.new
  end

  def create
    @sys_hero = @sys_meta_hero.sys_heros.new(params[:sys_hero].permit!)
    @sys_hero.name = @sys_meta_hero.name
    @sys_hero.talent = @sys_meta_hero.talent

    if @sys_hero.save
      redirect_to(admin_sys_meta_hero_sys_heros_path(@sys_meta_hero), :notice => 'SysHero 创建成功。')
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
