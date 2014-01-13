class GameLevelEnemy
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :is_boss, :type => Boolean, :default => false
  field :index, :type => Integer, :default => 1
  field :count, :type => Integer, :default => 1

  belongs_to :sys_enemy
  belongs_to :sys_game_level

  delegate :name, :atk, to: :sys_enemy
end
