# 徽章
class BadgeWinner
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :status, :type => Integer, :default => 0

  belongs_to :user
  belongs_to :badge

  scope :wore, where(:status => 1)
  scope :unware, where(:status => 0)
end
