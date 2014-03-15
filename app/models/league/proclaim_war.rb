class League::ProclaimWar
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :status, :type => Integer, :default => 0

  belongs_to :challenger, :class_name => 'League::League'
  belongs_to :defender, :class_name => 'League::League'

end