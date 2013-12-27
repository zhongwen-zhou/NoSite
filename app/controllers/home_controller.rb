# coding: utf-8
class HomeController < ApplicationController
  def index
    @articles = Article.all
    @leagues = League::League.all.limit(6)
    @share_content = {:web_spread => true}
    @guess_groups = [['中国队', '日本队'], ['皇马', '巴萨']]
  end

  def notice
  	render :json => {:rewards_count => Reward.where(:receiver => current_user, :status => 0).count,
  					 :messages_count => Message::Message.where(:receiver => current_user, :status => 0).count}
  end
end
