# coding: utf-8
class League::LeaguesController < ApplicationController
  # layout :false

  before_filter do
    @league = League::League.find(params[:id])
  end

  def new
  	@league = League::League.new
  end

  def create
    @league = current_user.create_league(league_params)
  	# @league = League::League.new(league_params)
  	# @league.add_member(current_user, true)
  	# @league.president_name = current_user.login
  	# @league.president = current_user
  	if @league.president?
  		return redirect_to root_path
  	else
      
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
    @league.members.where(:user => current_user).positive!
  end

  private
  def league_params
    params.require(:league_league).permit(:name, :declaration, :logo)
  end  
end
