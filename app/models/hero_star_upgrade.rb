class HeroStarUpgrade
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :star_level, :type => Integer, :default => 0  
  belongs_to :sys_meta_hero
  has_many :hero_star_upgrade_details, dependent: :destroy, autosave: true

	validates_uniqueness_of :star_level, :scope => :sys_meta_hero
end