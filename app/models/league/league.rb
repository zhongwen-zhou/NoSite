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


  def add_member(user, is_admin = false)
    member = self.members.build(:league => self, :user => user, :is_admin => is_admin, :status => is_admin ? 2 : 1)
  end

  def gift_welfare(gift_options)
    self.members.each do |member|

      Reward.create(:title => "工会福利",
                  :content => "工会有奖啊！我们奉上300金币，请笑纳！",
                  :classification => Reward::CLASSIFICATIONS['league'] ,
                  :personal_experience => 20,
                  :personal_coins => gift_options[:coins],
                  :receiver => member.user)

    end
  end

end