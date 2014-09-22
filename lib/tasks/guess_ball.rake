namespace :games do
  desc 'guess ball result'
  task :guess_ball_result => :environment do
 		users = User.where(:guessed_at.ne => nil, :guessed_out => false)
 		users.each do |user|

      guess_ball = GuessBall.last
      results = user.guessed_value
      coins = 0

      if user.guessed_at == guess_ball.index_date

        right = false

        if results.split('-').first.to_i == guess_ball.g1_result
          coins += 100
          right = true
        end

        if results.split('-').last.to_i == guess_ball.g2_result
          coins += 100
          right = true
        end

        unless right
          coins = 10
          Reward.create!(:receiver => user, :classification => 0, :personal_coins => coins, :content => "您 #{guess_ball.index_date.to_s} 的赌球一个都没有中哦，不过我们还是奖励你10金币，再接再厉哦！")
        else
          Reward.create!(:receiver => user, :classification => 0, :personal_coins => coins, :content => "您 #{guess_ball.index_date.to_s} 赌球中奖咯，请笑纳！")
        end
        user.set(:guessed_out => true)
      end
 		end
    File.open("#{Rails.root}/log/guess_ball_result.out", 'a') { |file| file.write("已成功处理 #{Date.current} 的足彩开奖信息！/n") }
  end
end
