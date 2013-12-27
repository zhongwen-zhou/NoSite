class Game::SysgameController < ApplicationController
  def guess
  	current_user.guess_ball(params[:game_value])
  end
end
