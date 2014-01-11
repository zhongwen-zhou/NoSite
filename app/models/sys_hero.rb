class SysHero
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :hp, :type => Integer, :default => 0  
  field :mp, :type => Integer, :default => 0 
  field :atk, :type => Integer, :default => 0 # 攻击力
  field :price, :type => Integer, :default => 200


  field :talent, :type => Integer, :default => 0 # 天赋

  has_many :hero_star_upgrades
  validates_presence_of :name
end