class Battle
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :status, :type => Integer, :default => 0

  belongs_to :user
  belongs_to :sys_game_level

  def result!
  	user.game_levels.create(:sys_game_level => sys_game_level, :stars => 3)
  end
end
