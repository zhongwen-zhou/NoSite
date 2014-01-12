class Admin::HeroStarUpgradesController < Admin::BaseController

  before_filter do
    @sys_meta_hero = SysMetaHero.find(params[:sys_meta_hero_id])
  end

  def index
    @heroStarUpgrades = @sys_meta_hero.hero_star_upgrades
  end

  def new
    @hero_star_upgrade = @sys_meta_hero.hero_star_upgrades.new
  end

  def create
    @hero_star_upgrade = @sys_meta_hero.hero_star_upgrades.new(params[:hero_star_upgrade].permit!)
    heros = SysHero.where(:id.in => params[:sys_hero_ids])
    if @hero_star_upgrade.save
      heros.each do|hero|
        @hero_star_upgrade.sys_heros.push hero
      end
      @hero_star_upgrade.save!
      redirect_to(admin_sys_meta_heros_path, :notice => 'SysHero 创建成功。')
    else
      render :action => :new
    end
  end

  def update
    if @sys_meta_hero.update_attributes(params[:sys_meta_hero].permit!)
      redirect_to(admin_sys_meta_heros_path, :notice => 'SysHero 更新成功。')
    else
      render :action => :new
    end
  end

  def destroy
    @sys_meta_hero = SysHero.find(params[:id])
    @sys_meta_hero.destroy
    redirect_to(admin_sys_meta_heros_path,:notice => "删除成功。")
  end
end
