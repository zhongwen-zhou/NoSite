class League::MessagesController < ApplicationController
  def create
  	league_id = params[:league_id] || params[:id]
		@league = League::League.find(league_id)
    @league.send_group_message(params[:message_message][:content]) unless params[:message_message][:content].strip.nil?
  end

  def index
		@league = League::League.find(params[:league_id])
  	@messages = @league.league_messages
  end
end
