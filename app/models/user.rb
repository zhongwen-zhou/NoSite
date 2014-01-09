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
end
