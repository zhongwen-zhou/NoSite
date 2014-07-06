# coding: utf-8
class HomeController < ApplicationController
  def index
    @articles = Article.desc(:created_at).limit(3)
    @leagues = League::League.all.limit(6)
    @share_content = {:web_spread => true}
    @guess_groups = [['中国队', '日本队'], ['皇马', '巴萨']]
  end

  def notice
    unless current_user.guessed_out
      guess_ball = GuessBall.instance
      results = current_user.guessed_value
      coins = 0
      p results
      p guess_ball.g1_result
      p guess_ball.g2_result
      if results.split('-').first == guess_ball.g1_result
        coins += 100
      end

      if results.split('-').last == guess_ball.g2_result
        coins += 100
      end

      if coins > 0
        Reward.create!(:receiver => current_user, :classification => 0, :personal_coins => coins, :content => '您赌球中奖咯，请笑纳！')
      end
      current_user.set(:guessed_out => true)
    else
    end
  	render :json => {:rewards_count => Reward.where(:receiver => current_user, :status => 0).count,
  					 :messages_count => Message::Message.where(:receiver => current_user, :status => 0).count}
  end
end
