# coding: utf-8
class Message::Communication
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel
  include Mongoid::SoftDelete
  include Mongoid::CounterCache
  include Redis::Objects

  field :status, :type => Integer, :default => 0
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  has_many :messages, :class_name => 'Message::Message'

  def self.user_communication(user)
    Message::Communication.any_of({:sender => user}, {:receiver => user})
  end

  def another_person(user)
    user == sender ? receiver : sender
  end

  def last_message
    messages.last
  end

end