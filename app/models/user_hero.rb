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
  field :delete_status, :type => Integer, :default => 0 


  field :selected, :type => Boolean, :default => false 

  belongs_to :user
  belongs_to :sys_hero

  scope :useable, where(:delete_status => 0)

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

  def eat_hero_and_upgrade(eated_hero_ids)
    total_experience = 0
    heros = UserHero.where(:id.in => eated_hero_ids)
    heros.each do |hero|
      total_experience += hero.experience
    end
    inc(:experience => total_experience)
    heros.each {|hero| hero.set(:delete_status => 1)}
  end
end
