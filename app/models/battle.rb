class Battle
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :status, :type => Integer, :default => 0
  field :stars, :type => Integer, :default => 0

  belongs_to :user
  belongs_to :sys_game_level

  def result!
  	battle!
  	return false if stars == 0
  	user.win_battle(self)
  end

  private
  def battle!
  	heros_total_atk = 0
  	enemies_total_atk = 0
  	user.heros.each do |hero|
  		heros_total_atk += hero.atk
  	end

  	sys_game_level.enemies.each do |enemy|
  		enemies_total_atk += enemy.atk
  	end

  	win_atk = heros_total_atk - enemies_total_atk

  	if win_atk > 200
  		stars = 3
  	elsif win_atk > 100
  		stars = 2
  	elsif win_atk > 0
  		stars = 1
  	else
  		stars = 0
  		return false
  	end
  end

  public
  def calculate
  	gold = sys_game_level.gold - (3-stars)*100
  	experience = sys_game_level.experience - (3-stars)*100
  	return gold, experience
  end
end
