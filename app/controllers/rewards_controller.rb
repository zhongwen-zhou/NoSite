# coding: utf-8
class RewardsController < ApplicationController
  # layout :false
  def index
    @type = params[:type] || 'game'
    @current_type = @type
    @rewards = Reward.where(:receiver => current_user, :classification => Reward::CLASSIFICATIONS[@type])
  end

  def receive
  	reward = Reward.find(params[:id])
  	reward.work!
  	return redirect_to rewards_path, :notice => "您已成功领取奖励！"
  end
end
