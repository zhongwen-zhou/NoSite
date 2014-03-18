class League::Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :content
  field :status, :type => Integer, :default => 0
  belongs_to :league, :class_name => 'League::League'
  belongs_to :sender, :class_name => 'User'
end