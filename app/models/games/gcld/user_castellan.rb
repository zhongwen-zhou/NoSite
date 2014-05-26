class Games::Gcld::UserCastellan < Games::Base
  #  ======
  field :price, :type => Integer, :default => 200 # 拍卖价格
  field :status, :type => Integer, :default => 0 # 拍卖状态
  belongs_to :user, :class_name => 'User'  # 所属用户
  belongs_to :castellan, :class_name => 'Games::Gcld::Castellan'  # 所属英雄

  def user_name
  	user.try(:name)
  end
end