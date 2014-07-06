class Game::SysgameController < ApplicationController
  def guess
  	value = "#{params[:group_1]}-#{params[:group_2]}"
  	current_user.guess_ball!(value.to_s)
  end
end
