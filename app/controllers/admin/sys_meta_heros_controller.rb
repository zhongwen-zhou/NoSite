class Admin::SysMetaHerosController < Admin::BaseController

  before_filter :except => [:index, :create, :new] do
    @sys_meta_hero = SysMetaHero.find(params[:id])
  end

  def index
    @sys_meta_heros = SysMetaHero.all
  end

  def new
    @sys_meta_hero = SysMetaHero.new
  end

  def create
    @sys_meta_hero = SysMetaHero.new(params[:sys_meta_hero].permit!)
    if @sys_meta_hero.save
      redirect_to(admin_sys_meta_heros_path, :notice => 'SysMetaHero 创建成功。')
    else
      render :action => :new
    end
  end

  def update
    if @sys_meta_hero.update_attributes(params[:sys_meta_hero].permit!)
      redirect_to(admin_sys_meta_heros_path, :notice => 'SysMetaHero 更新成功。')
    else
      render :action => :new
    end
  end

  def destroy
    @sys_meta_hero = SysMetaHero.find(params[:id])
    @sys_meta_hero.destroy
    redirect_to(admin_sys_meta_heros_path,:notice => "删除成功。")
  end
end
