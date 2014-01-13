class UserHero
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::SoftDelete

  field :hp, :type => Integer, :default => 0  
  field :mp, :type => Integer, :default => 0
  field :atk, :type => Integer, :default => 0 
  field :star_level, :type => Integer, :default => 1 
  field :level, :type => Integer, :default => 1
  field :experience, :type => Integer, :default => 0 
  field :leadership, :type => Integer, :default => 0 
  field :fighting_capacity, :type => Integer, :default => 0 

  field :selected, :type => Boolean, :default => false 

  belongs_to :user
  belongs_to :sys_hero
  belongs_to :sys_meta_hero

  delegate :hero_star_upgrades, :name, to: :sys_meta_hero
  delegate :show_name, to: :sys_hero


  def star_upgrade
    star_upgrade_details = hero_star_upgrades.where(:star_level => star_level).first.hero_star_upgrade_details
    star_upgrade_details.each do |detail|
      heros = user.heros.where(:id.ne => self.id, 
                               :sys_hero_id => detail.sys_hero_id).limit(detail.count)
      heros.destroy_all
    end
    inc(:star_level => 1)
  end

  def take
    set(:selected => true)
  end

  def takeoff
    set(:selected => false)
  end

  def eat_hero_and_upgrade(eated_hero_ids)
    total_experience = 0
    heros = UserHero.where(:id.in => eated_hero_ids)
    heros.each do |hero|
      total_experience += hero.experience
    end
    inc(:experience => total_experience)
    heros.destroy_all
    next_level_sys_hero = SysHero.where(:name => self.name, :star_level => self.star_level, :experience.gt => self.experience).asc(:level).first
    if next_level_sys_hero
      [:hp, :mp, :atk, :level, :star_level].each do |attr|
        self.set(attr => next_level_sys_hero[attr])
      end
    end
  end
end
