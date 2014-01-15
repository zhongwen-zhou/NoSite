# coding: utf-8
# 奖励
class Reward
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Redis::Objects

  field :title
  field :content
  field :classification, :type => Integer, :default => 0
  field :status, :type =>  Integer, :default => 0
  field :personal_coins, :type =>  Integer, :default => 0
  field :personal_experience, :type =>  Integer, :default => 0
  field :league_experience, :type =>  Integer, :default => 0
  field :league_coins, :type =>  Integer, :default => 0
  belongs_to :receiver, :class_name => 'User'
  belongs_to :badge
  
  index :updated_at => -1

  scope :received, where(:status => 1)
  scope :newly, where(:status => 0)

  CLASSIFICATIONS = { 'game' => 0, 'league' => 1, 'sys' => 2}

  def work!
    self.receiver.inc(:coins => self.personal_coins)
    self.receiver.inc(:score => self.personal_experience)
    self.set(:status => 1)
  end

end
