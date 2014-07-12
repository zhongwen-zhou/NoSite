# coding: utf-8
class GirlPicture
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::BaseModel

  field :title, type: String
  field :desc, type: String
  field :index, type: Integer, default: 1


  mount_uploader :f_image, GirlUploader
  mount_uploader :b_image, GirlUploader

end
