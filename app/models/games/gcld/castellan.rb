class Games::Gcld::Castellan < Games::Base
  # 武将
  field :name, :type => String
  field :tong_shuai, :type => Integer
  field :wu_li, :type => Integer
  field :zhi_li, :type => Integer
  field :zheng_zhi, :type => Integer
  belongs_to :role, :class_name => 'Games::Gcld::Role'  # 身份
  belongs_to :influence, :class_name => 'Games::Gcld::Influence'  # 势力
  belongs_to :role_type, :class_name => 'Games::Gcld::RoleType'  # 类型
  belongs_to :role_bz_type, :class_name => 'Games::Gcld::RoleBzType'  # 兵种
  #  ======
  field :price, :type => Integer, :default => 200 # 当前价格
  belongs_to :user, :class_name => 'User'  # 所属用户
  belongs_to :user_castellan, :class_name => 'Games::Gcld::UserCastellan'  # 当前最大的竞拍者
end