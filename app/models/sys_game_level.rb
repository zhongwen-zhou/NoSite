class SysGameLevel
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :index, :type => Integer, :default => 0  
  field :vitality, :type => Integer, :default => 0  

  belongs_to :parent, class_name: 'SysGameLevel'
  has_many :children, class_name: 'SysGameLevel', foreign_key: 'parent_id'
  has_many :enemies, class_name: 'GameLevelEnemy'

  validates_presence_of :name
end
