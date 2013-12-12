# coding: utf-8
class League::LeaguesController < ApplicationController
  # layout :false

  def new
  	@league = League::League.new
  end

  def create
  	@league = League::League.new(league_params)
  	@league.add_member(current_user, true)
  	@league.president_name = current_user.login
  	@league.president = current_user
  	if @league.save
  		return redirect_to root_path
  	else

  	end
  end

  def show
    @article = Article.find(params[:id])
  end

  def ask_for_join
  end

  private
  def league_params
    params.require(:league_league).permit(:name, :declaration, :logo)
  end  
end
