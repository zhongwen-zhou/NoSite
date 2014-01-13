class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::SoftDelete

  field :account
  field :password
  field :nickname
  
  field :level, :type => Integer, :default => 1
  field :experience, :type => Integer, :default => 0
  field :gold, :type => Integer, :default => 1000
  field :diamond, :type => Integer, :default => 0
  field :vitality, :type => Integer, :default => 0 # 活力


  has_many :heros, class_name: 'UserHero', dependent: :destroy, autosave: true
  has_many :game_levels, class_name: 'UserGameLevel', dependent: :destroy, autosave: true

  validates_presence_of :account, :password, :nickname
  validates_uniqueness_of :account, :nickname

  class << self
    def authorize!(params)
      user = User.where(:account => params[:account]).first
      return false unless user
      return false if user.password != params[:password]
      return user
    end
  end

  def buy_hero_from_sys_hero(sys_hero)
    if gold >= sys_hero.price
      user_hero = heros.new(:sys_hero => sys_hero,
                            :sys_meta_hero => sys_hero.sys_meta_hero,
                            :hp => sys_hero.hp,
                            :mp => sys_hero.mp,
                            :atk => sys_hero.atk,
                            :experience => (sys_hero.experience / 5).to_i
                            )
      if user_hero.valid?
        inc(:gold => - sys_hero.price)
        user_hero.save
        user_hero
      else
        nil
      end
    else
      nil
    end
  end

  def win_battle(battle)
    gold, experience = battle.calculate
    inc(:gold => gold)
    add_experience(experience)
    game_level = game_levels.where(:sys_game_level => battle.sys_game_level).first
    if game_level
      game_level.set(:stars => battle.stars) if battle.stars > game_level.stars
    else
      game_levels.create(:sys_game_level => battle.sys_game_level, :stars => battle.stars)
    end
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
