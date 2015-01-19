class RewardsController < ApplicationController
  def index
    @type = params[:type] || 'game'
    @current_type = @type
    @rewards = Reward.where(:receiver => current_user, :classification => Reward::CLASSIFICATIONS[@type]).desc(:created_at)
  end

  def receive
  	reward = Reward.find(params[:id])
  	reward.work!
  	return redirect_to rewards_path, :notice => "您已成功领取奖励！"
  end
end
