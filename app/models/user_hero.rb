class UserHero
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :hp, :type => Integer, :default => 0  
  field :mp, :type => Integer, :default => 0
  field :atk, :type => Integer, :default => 0 
  field :star_level, :type => Integer, :default => 0 
  field :level, :type => Integer, :default => 0 
  field :experience, :type => Integer, :default => 0 
  field :leadership, :type => Integer, :default => 0 
  field :fighting_capacity, :type => Integer, :default => 0 


  field :selected, :type => Boolean, :default => false 

  belongs_to :user
  belongs_to :sys_hero
end
