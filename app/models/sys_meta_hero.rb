class SysMetaHero
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :talent, :type => Integer, :default => 0 # 天赋

  has_many :hero_star_upgrades
  has_many :sys_heros

  validates_presence_of :name

  def talent_name
    case talent
      when 0
        '力量'
      when 1
        '敏捷'
      when 2
        '智力'
    end
  end  
end