class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :account
  field :password
  field :nickname
  
  field :level, :type => Integer, :default => 1
  field :experience, :type => Integer, :default => 0
  field :gold, :type => Integer, :default => 0
  field :diamond, :type => Integer, :default => 0
  field :vitality, :type => Integer, :default => 0 # 活力

  validates_presence_of :account, :password, :nickname

  has_many :heros, class_name: 'UserHero'
  has_many :game_levels, class_name: 'UserGameLevel'

  class << self
    def authorize!(params)
      user = User.where(:account => params[:account]).first
      return false unless user
      return false if user.password != params[:password]
      return user
    end
  end

  def win_battle(battle)
    gold, experience = battle.calculate
    inc(:gold => gold)
    add_experience(experience)
    game_levels.create(:sys_game_level => battle.sys_game_level, :stars => battle.stars)
  end

  def add_experience(experience)
    inc(:experience => experience)
    level_experience = GameSetting.user_level["level_#{level+1}"]
    inc(:level => 1) if self.experience >= level_experience
  end

  def sys_hero_ids
    heros.map &:sys_hero_id
  end
end
