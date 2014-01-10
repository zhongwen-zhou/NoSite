class UserHerosController < ApplicationController
  def create
    @sys_hero = SysHero.find(params[:id])
    @hero = @current_user.heros.new(:sys_hero => @sys_hero)
    @hero.copy_attr_from_hero(@sys_hero)
    if @hero.save
      redirect_to root_path, :notice => '购买成功'
    else
      redirect_to root_path, :notice => '购买失败'
    end
  end

  def level_upgrade
    @hero = @current_user.heros.find(params[:user_hero_id])
    if @hero.level_upgrade
      redirect_to root_path, :notice => '升级成功'
    else
      redirect_to root_path, :notice => '升级失败'
    end
  end

  def star_upgrade
    @hero = @current_user.heros.find(params[:user_hero_id])
    if @hero.star_upgrade
      redirect_to root_path, :notice => '升级成功'
    else
      redirect_to root_path, :notice => '升级失败'
    end
  end

  def take
    @hero = @current_user.heros.find(params[:user_hero_id])
    if @hero.take
      redirect_to root_path, :notice => '入列站斗成功'
    else
      redirect_to root_path, :notice => '入列站斗失败'
    end
  end    

  def takeoff
    @hero = @current_user.heros.find(params[:user_hero_id])
    if @hero.takeoff
      redirect_to root_path, :notice => '出列站斗成功'
    else
      redirect_to root_path, :notice => '出列站斗失败'
    end
  end  

end