class League::MessagesController < ApplicationController
  def create
  	league_id = params[:league_id] || params[:id]
		@league = League::League.find(league_id)
    @league.send_group_message(params[:league_message][:content]) unless params[:league_message][:content].strip.nil?
  end

  def index
		@league = League::League.find(params[:league_id])
  	@messages = @league.messages.desc(:created_at).paginate(:page => params[:page], :per_page => 10)
  	@message = @league.messages.build
  end
end
