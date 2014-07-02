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
    render :js
    # respond_to do |format|
    #   format.html do
    #     render :text => 'ok'
    #   end

    #   format.js
    # end
  end

  def welfare
    @league.gift_welfare(:coins => params[:coins])
  end

  def proclaim_war
    current_user.league.proclaim_war(@league)
    war_node = Bbs::Node.find(4)
    war_node.topics.create(:user => current_user.id,
                        :title => "[#{current_user.league.name}] 向 [#{@league.name}] 宣战！",
                        :body => "Come on!#{@league.name},我们来分个胜负吧！"
                        )
  end

  private
  def league_params
    params.require(:league_league).permit(:name, :declaration, :logo)
  end  
end
