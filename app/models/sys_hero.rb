class SysHero
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :level, :type => Integer, :default => 1
  field :star_level, :type => Integer, :default => 1
  field :hp, :type => Integer, :default => 0  
  field :mp, :type => Integer, :default => 0 
  field :atk, :type => Integer, :default => 0 # 攻击力
  field :price, :type => Integer, :default => 200
  field :experience, :type => Integer, :default => 0

  field :talent, :type => Integer, :default => 0 # 天赋

  belongs_to :hero_star_upgrade
  belongs_to :sys_meta_hero
  validates_presence_of :name

  delegate :hero_star_upgrades, :talent_name, :to => :sys_meta_hero

  def _star_upgrade_heros
    hero_star_upgrades.where(:star_level => star_level).first.try(:sys_heros) || []
  end

  def show_name
    "#{name}(#{star_level}--#{level})"
  end

end