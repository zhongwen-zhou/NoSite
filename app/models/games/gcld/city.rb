class Games::Gcld::City < Games::Base
  # 角色类型
  field :name
  belongs_to :type, :class_name => 'Games::Gcld::CityType'  
  belongs_to :infuence, :class_name => 'Games::Gcld::Influence'  
  belongs_to :castellan, :class_name => 'Games::Gcld::Castellan'  
end