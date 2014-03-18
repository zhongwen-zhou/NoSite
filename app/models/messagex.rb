# coding: utf-8
# 留言
class Messagex
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Redis::Objects

  field :content
  field :status, :type =>  Integer, :default => 0
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  
  index :updated_at => -1

  scope :recent_updated, desc(:updated_at)
  scope :published, where(publish: true)

  before_save :auto_set_value
  def auto_set_value
    if !self.body.blank?
      self.title = self.body.split("\n").first[0..50]
      self.word_count = self.body.length
    end
  end

  before_update :update_changes_count
  def update_changes_count
    self.changes_count = 0 if self.changes_count.blank?
    self.inc(changes_count: 1)
  end

end
