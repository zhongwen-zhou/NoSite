class HeroStarUpgrade
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :star_level, :type => Integer, :default => 0  
  field :count, :type => Integer, :default => 0
  belongs_to :sys_meta_hero
  has_many :sys_heros

end