# coding: utf-8
class Message::Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::SoftDelete
  include Mongoid::CounterCache
  include Redis::Objects

  field :content
  field :status, :type => Integer, :default => 0
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  belongs_to :communication, :class_name => 'Message::Communication'

end