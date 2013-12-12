# coding: utf-8
class League::League
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::SoftDelete
  include Mongoid::CounterCache
  include Redis::Objects

  field :name
  field :declaration
  field :members_count, :type => Integer, :default => 0
  field :level, :type => Integer, :default => 1
  field :experience, :type => Integer, :default => 0
  field :coins, :type => Integer, :default => 0
  field :president_name
  has_many :members, :class_name => 'League::Member', :dependent => :destroy, :autosave => true
  belongs_to :president, :class_name => 'User'

  mount_uploader :logo, League::LogoUploader

  scope :hot, desc(:users_count)

  validates_uniqueness_of :name, :case_sensitive => false

  index :name => 1

  def self.find_by_name(name)
    return nil if name.blank?
    name = name.downcase.strip
    query = name.match(/\p{Han}/) != nil ? name : /#{name}/i
    self.where(:name => query).first
  end

  def self.find_or_create_by_name(name)
    if not location = self.find_by_name(name)
      location = self.create(:name => name.strip)
    end
    location
  end

  def add_member(user, is_admin = false)
    self.members.build(:league => self, :user => user, :is_admin => is_admin)
  end
end