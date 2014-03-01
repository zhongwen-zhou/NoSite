# coding: utf-8
class League::LeaguesController < ApplicationController
  # layout :false

  before_filter :except => [:create, :index, :search] do
    @league = League::League.find(params[:id])
  end

  def index
    @leagues = League::League.all.desc(:activity)
  end

  def search
    keyword = params[:keyword]
    @leagues = League::League.where(:name => /#{keyword}/)
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
  end

  def ask_for_join
    @league.add_member(current_user, false)
    @league.save!
  end

  def agree_join
    @league.members.find(params[:member_id]).positive!
  end

  def refuse_join
    @league.members.find(params[:member_id]).destroy
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
