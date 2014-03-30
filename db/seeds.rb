public_section = Bbs::Section.create(:name => '公共', :sort => 0)
war_section = Bbs::Section.create(:name => '宣战', :sort => 1)
zk_section = Bbs::Section.create(:name => '战况', :sort => 2)

(1..20).each do |index|
  User.create(:login => "user_#{index}", 
    :name => "User_#{index}", 
    :password => 'tonytone',
    :password_confirmation => 'tonytone')
end

(1..6).each do |index|
  Badge.create(:name => "荣誉_#{index}",
               :desc => "荣誉_#{index} 的详细描述",
               :photo => File.open("db/images/badges/badge_#{index}.png"))
end

gs_node = public_section.nodes.create(:name => '灌水',
              :summary => '随意灌……',
              :sort => 0)

(1..10).each do |index|
  gs_node.topics.create(:user_id => index,
                        :title => "大家就随便灌水咯_#{index}",
                        :body => "大家就随便灌水咯\n 大家就随便灌水咯\n 大家就随便灌水咯\n 大家就随便灌水咯",
                        :excellent => index % 2)
end

zk_node = zk_section.nodes.create(:name => '战况',
              :summary => '你想要的战况这里都有……',
              :sort => 1)

(1..5).each do |index|
  zk_node.topics.create(:user_id => index,
                        :title => "战况热播，战争非常的激烈啊#{index}",
                        :body => "战况热播，战争非常的激烈啊\n 战况热播，战争非常的激烈啊\n 大家就随便灌水咯\n 大家就随便灌水咯",
                        :excellent => index % 2)
end

gl_node = public_section.nodes.create(:name => '攻略',
              :summary => '你想要的这里都有……',
              :sort => 1)

(1..10).each do |index|
  gl_node.topics.create(:user_id => index,
                        :title => "喜欢啥游戏说啥游戏咯_#{index}",
                        :body => "喜欢啥游戏说啥游戏咯\n 喜欢啥游戏说啥游戏咯\n 喜欢啥游戏说啥游戏咯\n 喜欢啥游戏说啥游戏咯",
                        :excellent => index % 2)
end

war_node = war_section.nodes.create(:name => '宣战',
              :summary => '谁不服的，上来啊单挑啊……',
              :sort => 0)

(1..5).each do |index|
  war_node.topics.create(:user_id => index,
                        :title => "宣战吧！_#{index}",
                        :body => "喜欢啥宣战吧！说啥游戏咯\n 喜欢啥游戏说啥游戏咯\n 喜欢宣战吧！说啥游戏咯\n 喜欢啥游戏说啥游戏咯",
                        :excellent => index % 2)
end

tony_user = User.create(:login => 'zhongwen', 
                        :name => 'Tony', 
                        :password => 'tonytone',
                        :password_confirmation => 'tonytone',
                        :is_admin => true)

(1..5).each do |index|
  Article.create(:title => "《DOTA2》英雄属性排行榜_#{index}",
                 :content=> "今日，官方为我们放出了3D电影《西游记之大闹天宫》终极版海报以及新剧照，在海报中，“美猴王”甄子丹、“玉皇大帝”周润发、“牛魔王”郭富城组队领衔，已经拉开“魔幻三雄”大PK的架势。影片将于2014年大年初一以3D/IMAX3D/中国巨幕形式上映。",
                 :illustration => File.open('db/images/articles/article_x.png'))
end

(1..6).each do |index|
  user = User.find(index)
  league = user.create_league({:name => "测试工会_#{index}",
                      :declaration => "如果不努力战斗，那么等待你的就是无尽的死亡轮回，一起来看看吧！",
                      :logo => File.open("db/images/leagues/league_#{index}.png")})
  league.add_member(User.find(20-index), false).positive!
end

User.all.each do |user|
  Badge.all.each_with_index do |badge, index|
    BadgeWinner.create(:user => user, :badge => badge, :status => index % 2)
  end
end