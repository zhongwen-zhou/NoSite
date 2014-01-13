class Admin::HeroStarUpgradeDetailsController < Admin::BaseController

  before_filter do
    @sys_meta_hero = SysMetaHero.find(params[:sys_meta_hero_id])
    @hero_star_upgrade = @sys_meta_hero.hero_star_upgrades.find(params[:hero_star_upgrade_id])
  end

  def index
    @hero_star_upgrade_details = @hero_star_upgrade.hero_star_upgrade_details
  end

  def new
    @hero_star_upgrade_detail = @hero_star_upgrade.hero_star_upgrade_details.new
  end

  def create
    @hero_star_upgrade_detail = @hero_star_upgrade.hero_star_upgrade_details.new(params[:hero_star_upgrade_detail].permit!)
    if @hero_star_upgrade_detail.save
      redirect_to(admin_sys_meta_hero_hero_star_upgrade_hero_star_upgrade_details_path(@sys_meta_hero, @hero_star_upgrade), :notice => 'SysHero 创建成功。')
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
