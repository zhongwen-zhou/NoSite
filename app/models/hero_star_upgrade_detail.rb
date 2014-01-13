class HeroStarUpgradeDetail
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :count, :type => Integer, :default => 0
  belongs_to :sys_meta_hero
  belongs_to :hero_star_upgrade
  belongs_to :sys_hero

  delegate :show_name, :to => :sys_hero

end