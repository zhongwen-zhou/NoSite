# coding: utf-8
class RewardsController < ApplicationController
  # layout :false
  def index
    # @article = Article.find(params[:id])
    @personal_rewards = Reward.where(:receiver => current_user)
  end

  def receive
  	reward = Reward.find(params[:id])
  	reward.work!
  	return redirect_to rewards_path, :notice => "您已成功领取奖励！"
  end
end
