class Games::Base
  # 基础信息
  include Mongoid::Document
  include Mongoid::Timestamps

  # 数据库id
  field :db_id, :type => Integer

end