class SysHero
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :hp, :type => Integer, :default => 0  
  field :mp, :type => Integer, :default => 0 
  field :atk, :type => Integer, :default => 0 #攻击力

  validates_presence_of :name
end
