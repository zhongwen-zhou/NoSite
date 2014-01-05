# coding: utf-8
class League::LeaguesController < ApplicationController
  # layout :false

  before_filter :except => [:create] do
    @league = League::League.find(params[:id])
  end

  def new
  	@league = League::League.new
  end

  def create
    @league = current_user.create_league(league_params)
    if @league.president?
  		return redirect_to root_path
  	else
      Rails.logger.info("-=-=-=-=-=-=-!!!!!!")
      Rails.logger.info("Error:#{@league.errors}")
      return redirect_to league_root_path
  	end
  end

  def show
    @article = Article.find(params[:id])
  end

  def ask_for_join
    @league.add_member(current_user, false)
    @league.save!
  end

  def agree_join
    @league.members.find(params[:member_id]).positive!
  end

  def sign_today
    current_user.sign_today!
  end

  def welfare
    @league.gift_welfare(:coins => params[:coins])
  end

  private
  def league_params
    params.require(:league_league).permit(:name, :declaration, :logo)
  end  
end
