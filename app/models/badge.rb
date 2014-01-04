# 徽章
class Badge
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :name
  field :desc

  mount_uploader :photo, PhotoUploader
end
