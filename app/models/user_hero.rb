class UserHero
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :hp, :type => Integer, :default => 0  
  field :mp, :type => Integer, :default => 0
  field :atk, :type => Integer, :default => 0 
  field :star_level, :type => Integer, :default => 0 
  field :level, :type => Integer, :default => 1
  field :experience, :type => Integer, :default => 0 
  field :leadership, :type => Integer, :default => 0 
  field :fighting_capacity, :type => Integer, :default => 0 


  field :selected, :type => Boolean, :default => false 

  belongs_to :user
  belongs_to :sys_hero

  delegate :name, to: :sys_hero

  def level_upgrade
    inc(:level => 1)
  end

  def star_upgrade
    inc(:star_level => 1)
  end

  def take
    set(:selected => true)
  end

  def takeoff
    set(:selected => false)
  end

  def copy_attr_from_hero(sys_hero)
    [:hp, :mp, :atk].each do |attr|
      self[attr] = sys_hero[attr]
    end
  end
end
