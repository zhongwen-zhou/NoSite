class Battle
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :status, :type => Integer, :default => 0

  belongs_to :user
  belongs_to :sys_game_level
end
