# coding: utf-8
class League::Member
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::SoftDelete
  include Mongoid::CounterCache
  include Redis::Objects

  # field :name
  # field :declaration
  # field :users_count, :type => Integer, :default => 0
  # field :level, :type => Integer, :default => 0
  # field :experience, :type => Integer, :default => 0
  # field :coins, :type => Integer, :default => 0
  # has_many :users

  field :is_admin, :type => Boolean, :default => false
  field :status, :type => Integer, :default => 0

  belongs_to :league, :class_name => 'League::League'
  counter_cache :name => :league, :inverse_of => :members
  belongs_to :user

  # mount_uploader :logo, League::LogoUploader

  scope :hot, desc(:users_count)
  scope :asking, where(:status => 1)
  scope :official, where(:status => 2)

  # validates_uniqueness_of :name, :case_sensitive => false

  after_save do |member|
    status = member.is_admin ? 2 : 1
    member.user.set(:join_league_status => status)
    member.user.league = member.league
    member.user.save!
  end

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

  def positive!
    self.set(:status => 2)
  end
end