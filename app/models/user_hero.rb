class UserHero
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::SoftDelete


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

  delegate :name,:_star_upgrade_heros, to: :sys_hero


  def show_name
    "#{name}(#{star_level}--#{level})"
  end

  def star_upgrade
    heros = user.heros.where(:id.ne => self.id, :sys_hero_id.in => (_star_upgrade_heros.map &:id))
    heros.destroy_all
    inc(:star_level => 1)

  end

  def take
    set(:selected => true)
  end

  def takeoff
    set(:selected => false)
  end

  def copy_attr_from_hero(sys_hero)
    [:hp, :mp, :atk, :level, :star_level].each do |attr|
      self[attr] = sys_hero[attr]
    end
    self.experience = (sys_hero.experience / 4).to_i
  end

  def eat_hero_and_upgrade(eated_hero_ids)
    total_experience = 0
    heros = UserHero.where(:id.in => eated_hero_ids)
    heros.each do |hero|
      total_experience += hero.experience
    end
    inc(:experience => total_experience)
    # heros.each {|hero| hero.set(:delete_status => 1)}
    heros.destroy_all
    next_level_sys_hero = SysHero.where(:name => self.name, :star_level => self.star_level, :experience.gt => self.experience).asc(:level).first
    if next_level_sys_hero
      [:hp, :mp, :atk, :level, :star_level].each do |attr|
        self[attr] = next_level_sys_hero[attr]
        self.set(attr => next_level_sys_hero[attr])
      end
    end
  end
end
