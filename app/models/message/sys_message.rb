# coding: utf-8
class Message::SysMessage
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :content
  field :status, :type => Integer, :default => 0
  belongs_to :receiver, :class_name => 'User'
end