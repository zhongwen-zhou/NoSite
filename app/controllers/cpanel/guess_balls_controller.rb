class Cpanel::GuessBallsController < Cpanel::ApplicationController

  def index

  end


  def edit_teams
  end

  def edit_results
  end

  def update_teams
    guess_ball = GuessBall.new
    last_guess_ball = GuessBall.last
    guess_ball.last_result = "#{last_guess_ball.g1_result}-#{last_guess_ball.g2_result}" if last_guess_ball
    guess_ball.index_date = Date.current
    guess_ball.g1_team1 = params[:g1_team1]
    guess_ball.g1_team2 = params[:g1_team2]
    guess_ball.g2_team1 = params[:g2_team1]
    guess_ball.g2_team2 = params[:g2_team2]
    guess_ball.save!
    redirect_to cpanel_guess_balls_path
  end

  def update_results
    guess_ball = GuessBall.last
    guess_ball.g1_result = params[:g1_result]
    guess_ball.g2_result = params[:g2_result]
    guess_ball.save!
    redirect_to cpanel_guess_balls_path
  end

end
