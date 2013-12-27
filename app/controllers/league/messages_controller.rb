class League::MessagesController < ApplicationController
  def create
		@league = League::League.find(params[:id])
    @league.send_group_message(params[:content]) unless params[:content].strip.nil?
  end

  def index
		@league = League::League.find(params[:league_id])
  	@messages = @league.league_messages
  end
end
