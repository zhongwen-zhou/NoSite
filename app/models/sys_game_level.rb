class SysGameLevel
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :index, :type => Integer, :default => 0  
  field :vitality, :type => Integer, :default => 0
  field :is_top, :type => Integer, :default => 0

  field :gold, :type => Integer, :default => 0
  field :experience, :type => Integer, :default => 0

  belongs_to :parent, class_name: 'SysGameLevel'
  has_many :children, class_name: 'SysGameLevel', foreign_key: 'parent_id', dependent: :destroy, autosave: true 
  has_many :enemies, class_name: 'GameLevelEnemy', dependent: :destroy, autosave: true 

  validates_presence_of :name

  scope :top, where(:is_top => 1)
end
