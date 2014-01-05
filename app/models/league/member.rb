class League::Member
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::CounterCache

  field :is_admin, :type => Boolean, :default => false
  field :status, :type => Integer, :default => 0

  belongs_to :league, :class_name => 'League::League'
  counter_cache :name => :league, :inverse_of => :members
  belongs_to :user


  scope :asking, where(:status => 1)
  scope :official, where(:status => 2)

  def positive!
    self.set(:status => 2)
    self.user.league = self.league
    self.user.set(:join_league_status => is_admin ? 2 : 1)
    self.user.save!
  end
end