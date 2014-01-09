class GameLevelEnemy
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :is_boss, :type => Boolean, :default => false  # 魔法值

  belongs_to :sys_enemy
  belongs_to :sys_game_level
end
